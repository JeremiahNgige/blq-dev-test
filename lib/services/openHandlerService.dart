import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';

class MyOpenChannelHandler extends OpenChannelHandler {
  @override
  void onMessageReceived(BaseChannel channel, BaseMessage message) {
    // Received a new message.
  }
}
