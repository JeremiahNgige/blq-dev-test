import 'package:blq_developer_test/app/app.locator.dart';
import 'package:blq_developer_test/services/openHandlerService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../config_keys/config_keys.dart';

class HomeChatViewModel extends FutureViewModel with sendChat, init, channels {
  final NavigationService _navigationService = locator<NavigationService>();
  final MyOpenChannelHandler _myOpenChannelHandler =
      locator<MyOpenChannelHandler>();

  void back() {
    _navigationService.back();
  }

  @override
  void disposeValues() {
    _chatController.dispose();
    notifyListeners();
  }

  @override
  Future<void> initialiseValues() async {
    _isLoading = true;
    _chatController = TextEditingController();
    _hasPrevious = false;
    _title = '';
    _participantCount = 0;
    _messages = [];
    _channel = OpenChannel(
        participantCount: _participantCount, operators: [], channelUrl: '');
    notifyListeners();
    // SendbirdChat.addChannelHandler('OpenChannel', MyOpenChannelHandler(this));
    // SendbirdChat.addConnectionHandler('OpenChannel', MyConnectionHandler(this));

    OpenChannel.getChannel(Config.openChannel).then((openChannel) {
      _channel = openChannel;
      notifyListeners();
      openChannel.enter().then((_) => initialisePage(Config.openChannel));
    });

    notifyListeners();
    // final openChannel = ;
    // Call the instance method of the result object in the openChannel parameter of the callback method.
    // The current user successfully enters the open channel as a participant,
    // and can chat with other users in the channel using APIs.
    // final params = MessageListParams()
    //   ..inclusive = true
    //   ..previousResultSize = 10
    //   ..nextResultSize = 10;
    //
    // final result = await _channel.getMessagesByTimestamp(
    //   double.maxFinite.toInt(),
    //   params,
    // );
    // // _messages = result;
    _isLoading = false;
    notifyListeners();
  }

  @override
  void onMessageReceived(BaseChannel channel, BaseMessage message) {
    if (message is UserMessage) {
      _messages.add(message);
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
  Future futureToRun() async {
    await initialiseValues().timeout(const Duration(seconds: 30),
        onTimeout: () async {
      _isLoading = false;
      notifyListeners();
    });
  }

  @override
  bool checkIsCurrentUser(User user) {
    if (user.userId != 'jeremiahngigeb') return false;
    return true;
  }

  @override
  void sendMessage(String text, OpenChannel channel) {
    _channel.sendUserMessage(
      UserMessageCreateParams(
        message: _chatController.value.text,
      ),
      handler: (UserMessage message, SendbirdException? e) async {
        if (e != null) {
          if (kDebugMode) debugPrint(e.toString());
        } else {
          addMessage(message, Config.openChannel);
        }
      },
    );

    _chatController.clear();
    notifyListeners();
  }

  @override
  void initialisePage(String channelUrl) {
    OpenChannel.getChannel(channelUrl).then((openChannel) {
      _query = PreviousMessageListQuery(
        channelType: ChannelType.open,
        channelUrl: channelUrl,
      )..next().then((messages) {
          _messages
            ..clear()
            ..addAll(messages);
          _title = '${openChannel.name} (${messages.length})';
          _hasPrevious = _query.hasNext;
          _participantCount = openChannel.participantCount;
          notifyListeners();
        });
    });
  }

  @override
  void addMessage(BaseMessage message, String channelUrl) {
    OpenChannel.getChannel(channelUrl).then((openChannel) {
      _messages.add(message);
      _title = '${openChannel.name} (${messages.length})';
      _participantCount = openChannel.participantCount;
      notifyListeners();
    });
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
}

mixin channels {
  late List<BaseMessage> _messages;

  List<BaseMessage> get messages => _messages;

  late OpenChannel _channel;

  OpenChannel get channel => _channel;

  late PreviousMessageListQuery _query;

  PreviousMessageListQuery get query => _query;

  late String _title;

  String get title => _title;

  late bool _hasPrevious;

  bool get hasPrevious => _hasPrevious;

  late int _participantCount;

  int get participantCount => _participantCount;

  void initialisePage(String channelUrl);

  bool checkIsCurrentUser(User user);

  void sendMessage(String text, OpenChannel channel);

  void onMessageReceived(BaseChannel channel, BaseMessage message);

  void addMessage(BaseMessage message, String channelUrl);
}
