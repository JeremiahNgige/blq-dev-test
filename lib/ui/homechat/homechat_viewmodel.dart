import 'package:blq_developer_test/app/app.locator.dart';
import 'package:blq_developer_test/services/openHandlerService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../config_keys/config_keys.dart';
import '../../models/chart_user.dart';
import '../../models/chat_message.dart';

class HomeChatViewModel extends FutureViewModel with sendChat, init, channels {
  final NavigationService _navigationService = locator<NavigationService>();
  final MyOpenChannelHandler _myOpenChannelHandler =
      locator<MyOpenChannelHandler>();

  void back() {
    _navigationService.back();
  }

  @override
  void disposeValues() {
    // TODO: implement disposeValues
    _chatController.dispose();
    notifyListeners();
  }

  @override
  Future<void> initialiseValues() async {
    // TODO: implement initialiseValues
    SendbirdChat.addChannelHandler('MyChannelHandler', _myOpenChannelHandler);
    _isLoading = true;
    _chatController = TextEditingController();
    _channel = await OpenChannel.getChannel(Config.openChannel);

    notifyListeners();
    try {
      // final openChannel = ;
      // Call the instance method of the result object in the openChannel parameter of the callback method.
      await _channel.enter();
      // The current user successfully enters the open channel as a participant,
      // and can chat with other users in the channel using APIs.
      final params = MessageListParams()
        ..inclusive = true
        ..previousResultSize = 10
        ..nextResultSize = 0;

      final result = await _channel.getMessagesByTimestamp(
        double.maxFinite.toInt(),
        params,
      );
      _messages = result;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      // Handle error.
    }
  }

  @override
  void onMessageReceived(BaseChannel channel, BaseMessage message) {
    if (message is UserMessage) {
    } else if (message is FileMessage) {
      // ...
    } else if (message is AdminMessage) {
      // ...
    }
    _myOpenChannelHandler.onMessageReceived(channel, message);
    _messages.add(message);
    notifyListeners();
  }

  @override
  void sendText(String message) {
    // TODO: implement sendText
  }

  @override
  List<ChatMessage> asDashChatMessage(List<BaseMessage> messages) {
    List<ChatMessage>? chatMessages;
    for (BaseMessage sMessage in messages) {
      chatMessages!.add(ChatMessage(
          text: sMessage.message, user: asDashChatUser(sMessage.sender!)));
    }
    return chatMessages!;
  }

  @override
  ChatUser asDashChatUser(User user) {
    return user == null
        ? ChatUser(uid: '', name: '', avatar: '')
        : ChatUser(
            uid: user.userId,
            name: user.nickname ?? '',
            avatar: user.profileUrl ?? '');
  }

  @override
  Future futureToRun() async {
    await initialiseValues().timeout(const Duration(seconds: 30),
        onTimeout: () async {
      _isLoading = false;
      notifyListeners();
    });
  }

  @override
  bool checkIsCurrentUser(User user) {
    // if (user != _sendbirdSdk.currentUser) return false;
    return true;
  }

  @override
  void sendMessage(String text, OpenChannel channel) {
    final params = UserMessageCreateParams(message: 'MESSAGE')
      ..data = 'DATA'
      ..customType = 'CUSTOM_TYPE'
      ..mentionType = MentionType
          .users // This could be either MentionType.users or MentionType.channel.
      ..metaArrays = [
        MessageMetaArray(key: 'itemType', value: ['tablet']),
        MessageMetaArray(key: 'quality', value: ['best', 'good']),
      ]
      ..translationTargetLanguages = [
        'fr',
        'de'
      ] // French and German, respectively.
      ..pushNotificationDeliveryOption = PushNotificationDeliveryOption.normal;
    try {
      final message = channel.sendUserMessage(params, handler: (message, e) {
        // The message is successfully sent to the channel.
        // The current user can receive messages from other users
        // through the onMessageReceived() method in event handlers.
      });
    } catch (e) {
      // Handle error.
      if (kDebugMode) debugPrint(e.toString());
    }
    // final sendMessage = channel.sendUserMessageWithText(text);
    // _messages.add(sendMessage);
    // notifyListeners();
  }
}

mixin init {
  late bool _isLoading;

  bool get isLoading => _isLoading;

  Future<void> initialiseValues();

  void disposeValues();
}

mixin sendChat {
  late TextEditingController _chatController;

  TextEditingController get chatController => _chatController;

  void sendText(String message);
}

mixin channels {
  late List<RootMessage> _messages;

  List<RootMessage> get messages => _messages;

  late OpenChannel _channel;

  OpenChannel get channel => _channel;

  List<ChatMessage> asDashChatMessage(List<BaseMessage> messages);

  ChatUser asDashChatUser(User user);

  bool checkIsCurrentUser(User user);

  void sendMessage(String text, OpenChannel channel);

  void onMessageReceived(BaseChannel channel, BaseMessage message);
}
