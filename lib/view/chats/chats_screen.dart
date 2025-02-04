import 'dart:developer';

import 'package:fire_chat_x/controller/chat_controller.dart';
import 'package:fire_chat_x/services/firestore_services.dart';
import 'package:fire_chat_x/utils/constants.dart';
import 'package:fire_chat_x/view/chats/components/add_button.dart';
import 'package:fire_chat_x/view/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/chat_list_view.dart';
import 'components/msg_field.dart';
import 'components/send_button.dart';

ChatController chatController = Get.put(ChatController());

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    log("Screen rebuilding...");
    // Call scrollToEnd after the screen has been built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      chatController.scrollToEnd();
    });
    return Scaffold(
      // APP BAR
      appBar: _buildAppBar(context),

      // BODY
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus!.unfocus();
        },
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: FireStoreServices.fireStoreServices.getChats(
                  homeController.currentUser!.email!,
                  chatController.receiver!.email!,
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }

                  if (snapshot.hasData) {
                    chatController.scrollToEnd();
                    return ChatListView(
                      chatList: snapshot.data!,
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),

            // MESSAGE TEXT FIELD
            const SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: defPadding, vertical: defPadding / 3),
                child: Row(
                  children: [

                    // ADD BUTTON
                    AddButton(),


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
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      toolbarHeight: 86,
      backgroundColor: Colors.transparent,
      bottom: const PreferredSize(
          preferredSize: Size.fromHeight(10),
          child: Divider(
            height: 0,
            thickness: 0.2,
          )),
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // PROFILE PHOTO
          CircleAvatar(
            backgroundColor: Colors.grey,
            backgroundImage: chatController.receiver!.photoURL != null
                ? NetworkImage(chatController.receiver!.photoURL!)
                : null,
            child: chatController.receiver!.photoURL == null
                ? const Icon(
                    Icons.person,
                    color: Colors.white,
                  )
                : const SizedBox(),
          ),

          const SizedBox(
            height: 4,
          ),

          // NAME
          Text(
            chatController.receiver!.displayName ?? "No name",
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),

          // ONLINE STATUS
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Online",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.green),
              ),
            ],
          ),

        ],
      ),
    );
  }
}
