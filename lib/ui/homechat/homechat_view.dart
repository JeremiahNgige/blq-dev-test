import 'package:blq_developer_test/ui/components/bubble_recipient.dart';
import 'package:blq_developer_test/ui/components/bubble_sender.dart';
import 'package:blq_developer_test/ui/components/custom_textfiled/custom_textfiled_view.dart';
import 'package:blq_developer_test/ui/homechat/homechat_viewmodel.dart';
import 'package:blq_developer_test/utils/custom_colors.dart';
import 'package:dash_chat/dash_chat.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

import '../../utils/sizes.dart';

class HomeChatView extends StatelessWidget {
  const HomeChatView({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ViewModelBuilder<HomeChatViewModel>.reactive(
      viewModelBuilder: () => HomeChatViewModel(),
      onViewModelReady: (model) => model.initialiseValues(),
      builder: (context, model, child) => Scaffold(
        body: SafeArea(
            child: DashChat(
                messages: [],
                user: ChatUser.fromJson({}),
                onSend: (dashChatMessage) {})),
      ),
    );
  }
}

class BottomChatOption extends StackedHookView<HomeChatViewModel> {
  const BottomChatOption({super.key});

  @override
  Widget builder(BuildContext context, HomeChatViewModel model) {
    var theme = Theme.of(context);
    return Container(
      padding: Spacing.all(10),
      color: theme.cardColor.withOpacity(0.3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {},
              splashColor: ColorResources.shimmerBaseColor,
              child: Padding(
                padding: Spacing.all(8),
                child: const Icon(Icons.add_rounded),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          SizedBox(
            child: CustomTextField(
                controller: model.chatController,
                errorTextId: 'enter chat',
                hint: 'Enter Text',
                validationMessage: '',
                inputType: TextInputType.text,
                label: ''),
          )
        ],
      ),
    );
  }
}

Widget messages(BuildContext context, bool isRecipient, String message,
    String userName, String time, String image) {
  return Container(
    padding: Spacing.vertical(10),
    child: (!isRecipient)
        ? senderBubble(context, message, time, userName, image)
        : recipientBubble(context, message, time, userName, image, true),
  );
}
