import 'package:fire_chat_x/controller/chat_controller.dart';
import 'package:fire_chat_x/services/firestore_services.dart';
import 'package:fire_chat_x/utils/constants.dart';
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 95,
        backgroundColor: Colors.transparent,
        bottom: const PreferredSize(
            preferredSize: Size.fromHeight(10),
            child: Divider(
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

            const SizedBox(height: 4,),

            // NAME
            Text(
              chatController.receiver!.displayName ?? "No name",
              style:
                  Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
            ),

            // ONLINE STATUS
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Online",
                  style:
                  Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.green),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
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
                  return ChatListView(
                    chatList: snapshot.data!,
                  );
                }

                return const SizedBox();
              },
            ),
          ),

          // MESSAGE TEXT FIELD
           SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defPadding),
              child: Row(
                children: [
                  // TEXT FIELD
                  const MsgField(),

                  const SizedBox(
                    width: defPadding,
                  ),

                  // SEND BUTTON
                  Obx(() => chatController.showSaveButton.value ? const SaveButton() : const SendButton()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
