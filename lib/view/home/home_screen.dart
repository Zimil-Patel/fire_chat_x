import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_chat_x/controller/home_controller.dart';
import 'package:fire_chat_x/model/user_model.dart';
import 'package:fire_chat_x/services/firestore_services.dart';
import 'package:fire_chat_x/services/noti_services.dart';
import 'package:fire_chat_x/utils/constants.dart';
import 'package:fire_chat_x/view/chats/chats_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/profile_circle_button.dart';

HomeController homeController = Get.put(HomeController());

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildHomeAppBar(context),
      body: FutureBuilder<List<QueryDocumentSnapshot<Map<String, dynamic>>>?>(
        future: FireStoreServices.fireStoreServices.getFireStoreUsersList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
              // shrinkWrap: true,
              // physics: const NeverScrollableScrollPhysics(),
              padding:
                  const EdgeInsets.only(bottom: 50, top: 14, left: 4, right: 4),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                UserModel user = UserModel.fromFireStore(
                  snapshot.data![index].data(),
                );

                return homeController.currentUser!.email != user.email
                    ? ListTile(
                        onTap: () {
                          chatController.setReceiver(user);
                          Get.toNamed('/chats');
                        },
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey,
                          backgroundImage: user.photoURL != null
                              ? NetworkImage(user.photoURL!)
                              : null,
                          child: user.photoURL == null
                              ? const Icon(
                                  Icons.person,
                                  color: Colors.white,
                                )
                              : const SizedBox(),
                        ),
                        title: Text(user.displayName ?? 'No name'),
                        subtitle: Text(
                          user.email ?? 'No email',
                          style: const TextStyle(color: Colors.white38),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white38,
                        ),
                      )
                    : const SizedBox();
              },
            );
          } else {
            return const Center(child: Text('No user found'));
          }
        },
      ),
    );
  }

  AppBar _buildHomeAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      title: Text(
        'Chats',
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontSize: height * 0.026,
              fontWeight: FontWeight.w500,
            ),
      ),
      leading: profileCircleButton(),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.camera_alt_outlined),
        ),
        IconButton(
          onPressed: () {
            NotiServices.notiServices.showNotification();
          },
          icon: const Icon(Icons.notifications_active_outlined),
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}
