import 'dart:developer';

import 'package:fire_chat_x/utils/constants.dart';
import 'package:fire_chat_x/view/chats/chats_screen.dart';
import 'package:flutter/material.dart';
import 'package:fire_chat_x/model/chat_model.dart';
import 'message_box.dart';

class ChatListView extends StatelessWidget {
  const ChatListView({
    super.key,
    required this.chatList,
  });

  final List<ChatModel> chatList;

  @override
  Widget build(BuildContext context) {
    log("Chat list rebuild...");

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            controller: chatController.scrollController,
            padding: const EdgeInsets.symmetric(
                horizontal: defPadding / 2, vertical: defPadding),
            reverse: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ...List.generate(
                  chatList.length,
                  (index) {

                    return MessageBox(chat: chatList[index], isLastMsg: index == chatList.length-1,);
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
