import 'dart:io';

import 'package:fire_chat_x/controller/home_controller.dart';
import 'package:fire_chat_x/services/auth_services.dart';
import 'package:fire_chat_x/services/messaging_services.dart';
import 'package:fire_chat_x/services/noti_services.dart';
import 'package:fire_chat_x/theme/theme_controller.dart';
import 'package:fire_chat_x/theme/themes.dart';
import 'package:fire_chat_x/utils/constants.dart';
import 'package:fire_chat_x/view/auth/auth_screen.dart';
import 'package:fire_chat_x/view/chats/chats_screen.dart';
import 'package:fire_chat_x/view/home/home_screen.dart';
import 'package:fire_chat_x/view/post%20screen/post_screen.dart';
import 'package:fire_chat_x/view/profile/profile_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:toastification/toastification.dart';

import 'controller/auth_controller.dart';
import 'controller/life_cycle_controller.dart';
import 'firebase_options.dart';

ThemeController themeController = Get.put(ThemeController());
AuthController authController = Get.put(AuthController());
HomeController homeController = Get.put(HomeController());

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await homeController.setCurrentUser();
  Get.put(AppLifecycleController());
  if(Platform.isAndroid){
    await MessagingService.messagingService.requestPermission();
    await MessagingService.messagingService.getDeviceToken();
  }

  await NotiServices.notiServices.initNotification();
  await GetStorage.init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const FireChatX());
}

class FireChatX extends StatelessWidget {
  const FireChatX({super.key});

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Obx(
      () => ToastificationWrapper(
        child: GetMaterialApp(
          getPages: [
            GetPage(name: '/auth', page: () => const AuthScreen()),
            GetPage(name: '/home', page: () => const HomeScreen()),
            GetPage(name: '/profile', page: () => const ProfileScreen()),
            GetPage(name: '/chats', page: () => const ChatsScreen()),
            GetPage(name: '/post', page: () => const PostScreen()),
          ],
          debugShowCheckedModeBanner: false,
          theme: ThemeClass.lightTheme,
          darkTheme: ThemeClass.darkTheme,
          themeMode:
              themeController.isDark.value ? ThemeMode.dark : ThemeMode.light,
          initialRoute: AuthServices.authServices.getCurrentUser() != null ? '/home' : '/auth',
          // initialRoute: '/post',
        ),
      ),
    );
  }
}
