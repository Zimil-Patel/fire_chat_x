import 'package:fire_chat_x/view/chats/chats_screen.dart';
import 'package:flutter/material.dart';

class MsgField extends StatelessWidget {
  const MsgField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        controller: chatController.msgCtrl,
        style: const TextStyle(fontSize: 14),
        focusNode: chatController.focusNode,
        onTap: (){
          WidgetsBinding.instance.addPostFrameCallback((_) {
            chatController.scrollToEnd();
          });
        },
        onTapOutside: (event) {
          // FocusManager.instance.primaryFocus!.unfocus();
        },
        decoration: InputDecoration(
          hintText: 'Message',
          hintStyle: const TextStyle(color: Colors.grey),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(color: Colors.black,)
          )
        ),
      ),
    );
  }
}
