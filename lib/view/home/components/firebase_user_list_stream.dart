import 'package:cached_network_image/cached_network_image.dart';
import 'package:fire_chat_x/model/user_model.dart';
import 'package:fire_chat_x/services/firestore_services.dart';
import 'package:fire_chat_x/view/chats/chats_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../main.dart';

class FirebaseUsersListStream extends StatelessWidget {
  const FirebaseUsersListStream({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<UserModel>>(
      stream: FireStoreServices.fireStoreServices.getFireStoreUsersList(),
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
            padding:
                const EdgeInsets.only(bottom: 50, top: 14, left: 4, right: 4),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              UserModel user = snapshot.data![index];

              return homeController.currentUser!.email != user.email
                  ? ListTile(
                      onTap: () {
                        chatController.setReceiver(user);
                        Get.toNamed('/chats');
                      },
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: user.photoURL == null
                            ? StreamBuilder<Object>(
                              stream: null,
                              builder: (context, snapshot) {
                                return const Icon(
                                    Icons.person,
                                    color: Colors.white,
                                  );
                              }
                            )
                            : ClipOval(
                              child: CachedNetworkImage(
                                width: double.infinity,
                                height: double.infinity,
                                imageUrl: user.photoURL!,
                                useOldImageOnUrlChange: true,
                                fit: BoxFit.cover,
                              ),
                            ),
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
    );
  }
}
