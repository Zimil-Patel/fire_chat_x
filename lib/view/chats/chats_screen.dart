import 'package:fire_chat_x/controller/chat_controller.dart';
import 'package:fire_chat_x/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/msg_field.dart';
import 'components/send_button.dart';

ChatController chatController = Get.put(ChatController());

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 80,
        backgroundColor: Colors.transparent,
        bottom: const PreferredSize(
            preferredSize: Size.fromHeight(10),
            child: Divider(
              thickness: 0.2,
            )),
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(
              radius: 24,
            ),
            Text(
              'Zimil Patel',
              style:
                  Theme.of(context).textTheme.bodyMedium!.copyWith(height: 2),
            )
          ],
        ),
      ),
      body:  Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: defPadding / 2, vertical: defPadding / 4),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: defPadding / 2),
                      padding: const EdgeInsets.symmetric(vertical: defPadding / 2, horizontal: defPadding),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blueAccent
                      ),
                      child: const Text('Message'),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // MESSAGE TEXT FIELD
          const SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: defPadding),
              child: Row(
                children: [
                  // TEXT FIELD
                  MsgField(),

                  SizedBox(
                    width: defPadding,
                  ),

                  // SEND BUTTON
                  SendButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
