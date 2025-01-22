import 'package:fire_chat_x/utils/constants.dart';
import 'package:fire_chat_x/view/chats/chats_screen.dart';
import 'package:fire_chat_x/view/home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SendButton extends StatelessWidget {
  const SendButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(defPadding),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blueAccent,
        ),
        child: Obx(
          () => Icon(
            chatController.showSaveButton.value
                ? Icons.done
                : Icons.arrow_upward_rounded,
            size: 20,
            color: Colors.white,
          ),
        ),
      ),
      onPressed: () async {
        if (chatController.showSaveButton.value) {
          await chatController
              .updateMessage(homeController.currentUser!.email!);
        } else {
          await chatController.sendMessage(homeController.currentUser!.email!);
        }
      },
    );
  }
}
