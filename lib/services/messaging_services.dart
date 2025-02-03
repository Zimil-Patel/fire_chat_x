import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

class MessagingService {
  MessagingService._();
  static final MessagingService messagingService = MessagingService._();

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // Request firebase messaging permission
  Future<void> requestPermission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if(settings.authorizationStatus != AuthorizationStatus.authorized){
      await requestPermission();
    }
  }


  // GENERATE DEVICE TOKEN
  Future<String?> getDeviceToken() async {
    final String? token = await _firebaseMessaging.getToken();
    log("Token: $token");
    return token;
  }
}