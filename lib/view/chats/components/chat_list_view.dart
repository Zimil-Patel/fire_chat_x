import 'package:fire_chat_x/utils/constants.dart';
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
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: defPadding / 2),
            reverse: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: chatList.map((chat) => MessageBox(chat: chat)).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
