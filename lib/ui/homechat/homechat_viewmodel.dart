import 'package:blq_developer_test/app/app.locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:sendbird_sdk/core/channel/group/group_channel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeChatViewModel extends BaseViewModel with sendChat, init, channels {
  final NavigationService _navigationService = locator<NavigationService>();

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
  void initialiseValues() {
    // TODO: implement initialiseValues
    _chatController = TextEditingController();
    notifyListeners();
  }

  @override
  void sendText(String message) {
    // TODO: implement sendText
  }
}

mixin init {
  void initialiseValues();

  void disposeValues();
}

mixin sendChat {
  late TextEditingController _chatController;

  TextEditingController get chatController => _chatController;

  void sendText(String message);
}

mixin channels {
  late GroupChannel _channel;

  GroupChannel get channel => _channel;
}
