import 'dart:developer';

import 'package:fire_chat_x/model/chat_model.dart';
import 'package:fire_chat_x/services/firestore_services.dart';
import 'package:fire_chat_x/view/chats/chats_screen.dart';
import 'package:fire_chat_x/view/chats/components/add_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void showPopupMenu(BuildContext context, ChatModel chat, dynamic containerKey) {
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
      const PopupMenuItem(
        value: 'delete',
        child: ListTile(
          leading: Icon(Icons.delete),
          title: Text('Delete'),
        ),
      ),
      const PopupMenuItem(
        value: 'edit',
        child: ListTile(
          leading: Icon(Icons.edit),
          title: Text('Edit'),
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
    } else if (value == 'delete') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 1),
          content: Text(
            'Message Deleted',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
        ),
      );
      // DELETE MESSAGE
      await FireStoreServices.fireStoreServices
          .deleteChat(chat.chatId, chat.sender, chat.receiver);
    } else if (value == 'edit') {
      if (chat.isImage) {
        showMediaOptions(context, isForUpdate: true, chat: chat);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(seconds: 1),
            content: Text(
              'Image Edited',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.black,
          ),
        );
      } else {
        // EDIT MESSAGE
        chatController.selectedMsgId = chat.chatId;
        chatController.showSaveButton.value = true;
        chatController.msgCtrl.text = chat.message;
      }
    }
  });
}
