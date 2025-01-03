import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../main.dart';
import '../../services/auth_services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fire Chats'),
        actions: [
          IconButton(onPressed: () async {
            await AuthServices.authServices.singOutUser();
            if(AuthServices.authServices.getCurrentUser() == null){
              await authController.setSignInStatusInStorage(false);
              Get.offAndToNamed('/auth');
            }
          }, icon: const Icon(Icons.logout_rounded),),
        ],
      ),
    );
  }
}
