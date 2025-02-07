import 'package:fire_chat_x/controller/home_controller.dart';
import 'package:fire_chat_x/model/user_model.dart';
import 'package:fire_chat_x/services/auth_services.dart';
import 'package:fire_chat_x/utils/constants.dart';
import 'package:fire_chat_x/view/home/home_screen.dart';
import 'package:fire_chat_x/view/profile/components/profile_photo_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../main.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UserModel user = homeController.currentUser!;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        backgroundColor: Colors.transparent,
        centerTitle: false,
        title: Text(
          'Profile',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: height * 0.026,
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          if (homeController.focusNode.hasFocus) {
            homeController.focusNode.unfocus();
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: defPadding),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top,
            ),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  const SizedBox(
                    height: defPadding * 2,
                  ),

                  // PROFILE PICTURE
                  const ProfilePhotoSection(),

                  const SizedBox(
                    height: defPadding,
                  ),

                  // USER PROFILE
                  GetBuilder<HomeController>(
                    builder: (controller) => Text(
                      controller.currentUser!.displayName != null
                          ? controller.currentUser!.displayName!
                          : 'Not set',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: height * 0.028),
                    ),
                  ),
                  // USER PROFILE
                  Text(
                    user.email != null ? user.email! : 'Not set',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: height * 0.016,
                        ),
                  ),

                  const SizedBox(
                    height: 14,
                  ),

                  const Row(
                    children: [
                      Text(
                        '  Display Name',
                        style: TextStyle(fontSize: 14, height: 2),
                      ),
                    ],
                  ),

                  Card(
                    color: Colors.white12,
                    shape: const RoundedRectangleBorder(),
                    child: Column(
                      children: [
                        const Divider(
                          height: 0,
                          color: CupertinoColors.systemGrey,
                        ),
                        TextField(
                          focusNode: homeController.focusNode,
                          controller: homeController.txtName,
                          onSubmitted: (value) async {
                            await homeController.updateDisplayName();
                          },
                          decoration: const InputDecoration(
                            hintText: 'Enter your name',
                            hintStyle: TextStyle(
                              color: CupertinoColors.systemGrey,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: defPadding / 2),
                          ),
                        ),
                        const Divider(
                          height: 0,
                          color: CupertinoColors.systemGrey,
                        )
                      ],
                    ),
                  ),

                  const Spacer(),

                  Padding(
                    padding: const EdgeInsets.only(bottom: defPadding * 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Log out',
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: height * 0.020,
                                  ),
                        ),
                        IconButton(
                          onPressed: () async {
                            await AuthServices.authServices.singOutUser();
                            if (AuthServices.authServices.getCurrentUser() ==
                                null) {
                              await authController
                                  .setSignInStatusInStorage(false);
                              Get.offAndToNamed('/auth');
                            }
                          },
                          icon: const Icon(Icons.logout_rounded),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
