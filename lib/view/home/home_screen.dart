import 'package:fire_chat_x/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../main.dart';
import '../../services/auth_services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {


    User? user = AuthServices.user;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Fire Chats',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: height * 0.026,
                fontWeight: FontWeight.w500,
              ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(
              left: defPadding / 2,
              top: defPadding / 2,
              bottom: defPadding / 2),
          child: GestureDetector(
            onTap: () {
              Get.toNamed('/profile');
            },
            child: CircleAvatar(
                backgroundColor: Colors.grey,
                backgroundImage: user!.photoURL != null ? NetworkImage(user.photoURL!) : null,
                child: user.photoURL == null ? const Icon(
                  Icons.person,
                  color: Colors.white,
                ) : const SizedBox()
            ),
          ),
        ),
      ),
    );
  }
}
