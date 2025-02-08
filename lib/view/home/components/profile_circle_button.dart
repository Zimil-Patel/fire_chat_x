
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fire_chat_x/services/firestore_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../main.dart';

profileCircleButton() {
  return GestureDetector(
    onTap: () {
      Get.toNamed('/profile');
    },
    child: Container(
      margin: const EdgeInsets.all(8),
      child: StreamBuilder<String>(
            stream: FireStoreServices.fireStoreServices.getProfilePhoto(homeController.currentUser!.email),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, color: Colors.white),
                );
              } else if (snapshot.hasData) {
                return ClipOval(
                  child: snapshot.data != null
                      ? CachedNetworkImage(
                          imageUrl: snapshot.data!,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const CircleAvatar(
                            backgroundColor: Colors.grey,
                            child: Icon(Icons.person, color: Colors.white),
                          ),
                          errorWidget: (context, url, error) =>
                              const CircleAvatar(
                            backgroundColor: Colors.grey,
                            child: Icon(Icons.person, color: Colors.white),
                          ),
                        )
                      : const CircleAvatar(
                          backgroundColor: Colors.grey,
                          child: Icon(Icons.person, color: Colors.white),
                        ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
    ),
  );
}
