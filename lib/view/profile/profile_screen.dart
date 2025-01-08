import 'package:fire_chat_x/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios_rounded, color: Theme.of(context).colorScheme.onSurface,),
        ),
        backgroundColor: Colors.transparent,
        centerTitle: false,
        title: Text(
          'Profile',
          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                fontSize: height * 0.026,
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: defPadding * 2,
            ),

            // PROFILE PICTURE
            Center(
              child: CircleAvatar(
                radius: height * 0.05,
                backgroundColor: Colors.grey,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: height * 0.05,
                ),
              ),
            ),

            // USER PROFILE
            Text(
              'Star Boy',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: height * 0.028
                  ),
            ),
            // USER PROFILE
            Text(
              'jash24@gmail.com',
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: height * 0.016,
              ),
            )
          ],
        ),
      ),
    );
  }
}
