import 'package:fire_chat_x/view/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constants.dart';

Padding profileCircleButton() {
  return Padding(
    padding: const EdgeInsets.only(
        left: defPadding / 2, top: defPadding / 2, bottom: defPadding / 2),
    child: GestureDetector(
      onTap: () {
        Get.toNamed('/profile');
      },
      child: FutureBuilder(
          future: homeController.setCurrentUser(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return CircleAvatar(
                backgroundColor: Colors.grey,
                backgroundImage: homeController.currentUser!.photoURL != null
                    ? NetworkImage(homeController.currentUser!.photoURL!)
                    : null,
                child: homeController.currentUser!.photoURL == null
                    ? const Icon(
                        Icons.person,
                        color: Colors.white,
                      )
                    : const SizedBox(),
              );
            } else if(snapshot.connectionState == ConnectionState.waiting){
              return const CircleAvatar(
                backgroundColor: Colors.grey,
                  child: Icon(
                Icons.person,
                color: Colors.white,
              ));
            } else {
              return const CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                  ));
            }
          }),
    ),
  );
}
