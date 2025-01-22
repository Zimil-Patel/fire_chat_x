import 'package:fire_chat_x/view/home/home_screen.dart';
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

            return Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                backgroundImage: homeController.currentUser!.photoURL != null
                    ? NetworkImage(homeController.currentUser!.photoURL!,)
                    : null,
                child: homeController.currentUser!.photoURL == null
                    ? const Icon(
                  Icons.person,
                  color: Colors.white,
                )
                    : const SizedBox(),
              ),
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
  );
}
