import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_chat_x/model/chat_model.dart';
import 'package:fire_chat_x/services/firestore_services.dart';
import 'package:fire_chat_x/utils/constants.dart';
import 'package:fire_chat_x/view/chats/chats_screen.dart';
import 'package:fire_chat_x/view/home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
        child: const Icon(
          Icons.send_rounded,
          size: 20,
          color: Colors.white,
        ),
      ),
      onPressed: () async {
        if (chatController.msgCtrl.text.isNotEmpty) {
          ChatModel chat = ChatModel(
            message: chatController.msgCtrl.text,
            sender: homeController.currentUser!.email!,
            receiver: chatController.receiver!.email!,
            time: Timestamp.now(),
          );

          await FireStoreServices.fireStoreServices.sendChat(chat);

          chatController.msgCtrl.clear();
        }
      },
    );
  }
}
