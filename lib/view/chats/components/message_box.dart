import 'package:fire_chat_x/model/chat_model.dart';
import 'package:fire_chat_x/utils/constants.dart';
import 'package:fire_chat_x/view/home/home_screen.dart';
import 'package:flutter/material.dart';


class MessageBox extends StatelessWidget {
  const MessageBox({
    super.key, required this.chat,
  });

  final ChatModel chat;

  @override
  Widget build(BuildContext context) {
    final bool isSender = chat.sender == homeController.currentUser!.email!;
    final alignment = isSender ? Alignment.centerRight : Alignment.centerLeft;
    final margin = isSender ? const EdgeInsets.only(
        bottom: defPadding / 2, left: defPadding) : const EdgeInsets.only(
        bottom: defPadding / 2, right: defPadding);

    return Align(
      alignment: alignment,
      child: Container(
        margin: margin,
        padding: const EdgeInsets.symmetric(
            vertical: defPadding / 2, horizontal: defPadding),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.blueAccent
        ),
        child: Text(chat.message, style: Theme
            .of(context)
            .textTheme
            .bodyLarge,),
      ),
    );
  }
}
