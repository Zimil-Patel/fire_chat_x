import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../main.dart';
import 'components/auth_screen_intro.dart';
import 'components/segmented_button.dart';
import 'components/sign_in_tab.dart';
import 'components/sign_up_tab.dart';

Map<String, Widget> segmentTabs = {
  'phone': const SignInTab(),
  'email': const SignInTab(),
  'signUp': const SignUpTab(),
};

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // BODY
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context)
                .size
                .height, // Minimum height to take full screen
          ),
          child: IntrinsicHeight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).padding.top / 4),

                // INTRO TEXTS AND ICON
                authScreenIntro(context),

                // SEGMENTED BOX
                const BuildSegmentedButton(),

                // TABS
               Expanded(
                 child: Container(
                      decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(100)),
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF3977F0), // Base color
                            Color(0xFF4A90E2), // Lighter shade
                            Color(0xFF2C5ED5), // Darker shade
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Obx(
                        () => segmentTabs[authController.segmentValue.value]!,
                      ),
                    ),
               ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
