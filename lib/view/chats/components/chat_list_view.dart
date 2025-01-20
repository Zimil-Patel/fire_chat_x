import 'package:fire_chat_x/model/chat_model.dart';
import 'package:fire_chat_x/utils/constants.dart';
import 'package:flutter/material.dart';

import 'message_box.dart';


class ChatListView extends StatelessWidget {
  const ChatListView({
    super.key, required this.chatList,
  });

  final List<ChatModel> chatList;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: defPadding / 2, vertical: defPadding / 4),
      child: Column(
        children: [
          ...List.generate(chatList.length, (index) {
            return MessageBox(chat: chatList[index],);
          },),
        ],
      ),
    );
  }
}
