import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_chat_x/model/chat_model.dart';
import 'package:fire_chat_x/utils/constants.dart';
import 'package:fire_chat_x/view/chats/components/show_menu_options.dart';
import 'package:fire_chat_x/view/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageBox extends StatelessWidget {
  MessageBox({
    super.key,
    required this.chat,
  });

  final GlobalKey containerKey = GlobalKey();
  final ChatModel chat;

  @override
  Widget build(BuildContext context) {
    final bool isSender = chat.sender == homeController.currentUser!.email!;
    final alignment = isSender ? Alignment.centerRight : Alignment.centerLeft;
    final margin = isSender
        ? const EdgeInsets.only(bottom: defPadding / 2, left: defPadding)
        : const EdgeInsets.only(bottom: defPadding / 2, right: defPadding);
    final time = getTimeFormat(chat.time);

    return GestureDetector(
      onLongPressStart: (details) => showPopupMenu(context, chat, containerKey),
      child: Align(
        alignment: alignment,
        child: Container(
          key: containerKey,
          margin: margin,
          padding: const EdgeInsets.symmetric(
              vertical: defPadding / 2, horizontal: defPadding),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.blueAccent),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  right: 8.0,
                ),
                child: Text(
                  chat.message,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: height * 0.018,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),

              // TIME OF THE MESSAGE
              Text(
                time,
                textAlign: TextAlign.end,
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontSize: height * 0.012, fontWeight: FontWeight.w900),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// CONVERT TIME STAMP INTO HOUR
getTimeFormat(Timestamp timeStamp) {
  final format = DateFormat("jm");
  return format.format(timeStamp.toDate());
}
