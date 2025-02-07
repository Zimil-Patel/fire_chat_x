import 'package:cached_network_image/cached_network_image.dart';
import 'package:fire_chat_x/controller/home_controller.dart';
import 'package:fire_chat_x/utils/constants.dart';
import 'package:fire_chat_x/view/home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

profileCircleButton() {
  return GestureDetector(
    onTap: () {
      Get.toNamed('/profile');
    },
    child: FutureBuilder(
      future: homeController.setCurrentUser(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return GetBuilder<HomeController>(
            builder: (controller) => Container(
              margin: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: controller.currentUser!.photoURL != null
                    ? CachedNetworkImage(
                        imageUrl: controller.currentUser!.photoURL!,
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
              ),
            ),
          );
        } else {
          return Container(
            width: 40, // Set width
            height: 40, // Set height
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: const CircleAvatar(
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, color: Colors.white),
            ),
          );
        }
      },
    ),
  );
}
