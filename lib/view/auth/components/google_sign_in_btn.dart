import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

import '../../../main.dart';
import '../../../services/auth_services.dart';
import '../../../utils/constants.dart';


CupertinoButton googleSignInBtn(BuildContext context) {
  return CupertinoButton(
    onPressed: () async {
      authController.isLoading.value = true;
      final result = await AuthServices.authServices.signInWithGoogle();
      if(result){
        await authController.setSignInStatusInStorage(result);
        authController.isLoading.value = false;
        Get.offAndToNamed('/home');
      } else {
        toastification.show(
          style: ToastificationStyle.minimal,
          title: const Text('Sign in failed!!'),
          description: const Text('Please try again.'),
          autoCloseDuration: const Duration(seconds: 2),
          type: ToastificationType.error,
        );
        authController.isLoading.value = false;
      }
    },
    padding: EdgeInsets.zero,
    child: Container(
      padding: const EdgeInsets.symmetric(
        vertical: defPadding / 1.2,
        horizontal: defPadding * 2,
      ),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white.withOpacity(0.9),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 0.2,
            spreadRadius: 0.4,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ICON
          Image.asset(
            'assets/png/google_icon.png',
            height: height * 0.030,
            width: height * 0.030,
          ),

          const SizedBox(
            width: defPadding,
          ),

          // LABEL
          Text(
            'Continue with Google',
            style:
            Theme
                .of(context)
                .textTheme
                .displayMedium!
                .copyWith(
              fontSize: height * 0.018,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    ),
  );
}