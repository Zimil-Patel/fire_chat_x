import 'dart:developer';

import 'package:fire_chat_x/model/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void showPopupMenuForReceiverMsg(BuildContext context, ChatModel chat, dynamic containerKey) {
  final RenderBox renderBox =
  containerKey.currentContext!.findRenderObject() as RenderBox;

  // Get the position of the container on the screen
  final Offset containerPosition = renderBox.localToGlobal(Offset.zero);

  log("----------- ${chat.chatId} ----------");


  showMenu(
    context: context,
    color: Colors.black,
    position: RelativeRect.fromLTRB(
      containerPosition.dx,
      containerPosition.dy + renderBox.size.height, // Below the container
      containerPosition.dx + renderBox.size.width,
      containerPosition.dx,
    ),
    items: [
      const PopupMenuItem(
        value: 'copy',
        child: ListTile(
          leading: Icon(Icons.copy),
          title: Text('Copy'),
        ),
      ),
    ],
  ).then((value) async {
    // Handle menu selection
    if (value == 'copy') {
      Clipboard.setData(ClipboardData(text: chat.message));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 1),
          content: Text(
            'Message copied to clipboard!',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
        ),
      );
    }
  });
}
