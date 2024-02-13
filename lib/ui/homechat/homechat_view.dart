import 'package:blq_developer_test/ui/components/bubble_recipient.dart';
import 'package:blq_developer_test/ui/components/bubble_sender.dart';
import 'package:blq_developer_test/ui/components/custom_textfiled/custom_textfiled_view.dart';
import 'package:blq_developer_test/ui/homechat/homechat_viewmodel.dart';
import 'package:blq_developer_test/utils/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

import '../../utils/sizes.dart';

class HomeChatView extends StatefulWidget {
  const HomeChatView({super.key});

  @override
  State<HomeChatView> createState() => _HomeChatViewState();
}

class _HomeChatViewState extends State<HomeChatView> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ViewModelBuilder<HomeChatViewModel>.reactive(
      viewModelBuilder: () => HomeChatViewModel(),
      onViewModelReady: (model) => model.initialiseValues(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                model.back();
              },
              splashColor: ColorResources.shimmerBaseColor,
              child: const Icon(
                Icons.arrow_back_ios_new_outlined,
              ),
            ),
          ),
          centerTitle: true,
          title: Text(
            'BLQ TEST',
            style: theme.textTheme.titleMedium!
                .copyWith(fontWeight: FontWeight.w900),
          ),
          actions: [
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {},
                splashColor: ColorResources.shimmerBaseColor,
                child: const Icon(
                  Icons.menu_outlined,
                ),
              ),
            )
          ],
        ),
        body: SafeArea(
          child: (model.isLoading)
              ? const SizedBox.shrink()
              : Container(
                  margin: Spacing.fromLTRB(8, 8, 8, 100),
                  child: ListView.builder(
                      itemCount: model.messages.length,
                      itemBuilder: (context, index) =>
                          (model.checkIsCurrentUser(
                                  model.messages[index].sender!))
                              ? messages(
                                  context,
                                  false,
                                  model.messages[index].message,
                                  model.messages[index].sender!.nickname,
                                  model.messages[index].createdAt.toString(),
                                  model.messages[index].sender!.profileUrl)
                              : messages(
                                  context,
                                  true,
                                  model.messages[index].message,
                                  model.messages[index].sender!.nickname,
                                  model.messages[index].createdAt.toString(),
                                  model.messages[index].sender!.profileUrl))),
        ),
        bottomSheet: const BottomChatOption(),
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
      color: theme.cardColor,
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
              label: '',
              callback: () {
                model.sendMessage(model.chatController.text, model.channel);
              },
            ),
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
