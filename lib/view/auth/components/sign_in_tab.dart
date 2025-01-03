import 'package:fire_chat_x/view/auth/components/text_fields.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../main.dart';
import '../../../services/auth_services.dart';
import '../../../utils/constants.dart';
import 'google_sign_in_btn.dart';

class SignInTab extends StatelessWidget {
  const SignInTab({
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
            // Sign-In Heading
            Text(
              'Sign In',
              style: TextStyle(
                color: Colors.white,
                fontSize: height * 0.04,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8.0),

            // SUBTEXT
            const Text(
              'Welcome back! Please sign in to continue.',
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
            const SizedBox(height: defPadding / 2),

            // Forgot Password
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // Navigate to Forgot Password screen
                },
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: height * 0.016,
                  ),
                ),
              ),
            ),
            const SizedBox(height: defPadding / 2),

            // Sign-In Button
            ElevatedButton(
              onPressed: () async {
                var email = authController.emailCtrl.text;
                var password = authController.passCtrl.text;
                final result = await AuthServices.authServices.signInWithEmailAndPassword(email: email, password: password);
                if(result){
                  Get.offAndToNamed('/home');
                  await authController.setSignInStatusInStorage(result);
                  authController.clearCtrl();
                } else {
                  Get.snackbar('Login Failed!!!', 'Invalid email or password.',);
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: const Color(0xFF3977F0),
                backgroundColor: Colors.white,
                // Text color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 40.0,
                  vertical: 15.0,
                ),
              ),
              child: const Text(
                'Sign In',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: defPadding),

            // Suggestion Text
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'New to Signal?',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14.0,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    authController.clearCtrl();
                    authController.segmentValue.value = 'signUp';
                  },
                  child: const Text(
                    'Sign up here',
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
