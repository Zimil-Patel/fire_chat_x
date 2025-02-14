import 'package:fire_chat_x/view/auth/components/text_fields.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

import '../../../main.dart';
import '../../../services/auth_services.dart';
import '../../../utils/constants.dart';
import 'google_sign_in_btn.dart';
import 'lottie_loading_animation.dart';

class SignUpTab extends StatelessWidget {
  const SignUpTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Sign-Up Heading
            Text(
              'Sign Up',
              style: TextStyle(
                color: Colors.white,
                fontSize: height * 0.04,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),


            // SUBTEXT
            const Text(
              'Create your account to get started.',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 40.0),

            // Email TextField
            buildEmailTextField(),
            const SizedBox(height: 20.0),

            // Password TextField
            buildPasswordTextField(),
            const SizedBox(height: 30.0),

            // Sign-Up Button
            Obx(
              () => authController.isLoading.value ? const LottieLoadingAnimation() : ElevatedButton(
                onPressed: () async {
                  authController.isLoading.value = true;
                  var email = authController.emailCtrl.text;
                  var password = authController.passCtrl.text;
                  final result = await AuthServices.authServices.createUserWithEmailAndPassword(email: email, password: password);
                  if(result){
                    toastification.show(
                      style: ToastificationStyle.minimal,
                      title: const Text('Sign up success'),
                      description: const Text('Now you can sign in'),
                      autoCloseDuration: const Duration(seconds: 2),
                      type: ToastificationType.success,
                    );
                    await authController.setSignInStatusInStorage(result);
                    authController.emailCtrl.clear();
                    authController.passCtrl.clear();
                  } else {
                    toastification.show(
                      style: ToastificationStyle.minimal,
                      title: const Text('Sign up failed!!'),
                      description: const Text('Please try again.'),
                      autoCloseDuration: const Duration(seconds: 2),
                      type: ToastificationType.error,
                    );
                  }
                  authController.isLoading.value = false;
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color(0xFF3977F0),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 15.0,
                  ),
                ),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),

            // Suggestion Text
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Already have an account?',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14.0,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Navigate to Sign-In screen
                    authController.clearCtrl();
                    authController.segmentValue.value = 'email';
                  },
                  child: const Text(
                    'Sign in here',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            // Continue with Google Button
            googleSignInBtn(context),

            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
