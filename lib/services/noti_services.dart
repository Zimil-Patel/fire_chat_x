import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotiServices {
  NotiServices._();
  static final NotiServices notiServices = NotiServices._();

  final _notificationsPlugin = FlutterLocalNotificationsPlugin();


  // INITIALIZE NOTIFICATION
  Future<void> initNotification() async {

    if(Platform.isAndroid) {
      await _notificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()!.requestNotificationsPermission();
    }

    // SETTING FOR ANDROID
    const initSettingAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // SETTING UP FOR IOS
    const initSettingIos = DarwinInitializationSettings(
      requestBadgePermission: true,
      requestAlertPermission: true,
      requestSoundPermission: true,
    );

    // INIT SETTING
    const initSetting = InitializationSettings(
      android: initSettingAndroid,
      iOS: initSettingIos,
    );

    // INITIALIZE NOTI
    await _notificationsPlugin.initialize(initSetting);
  }

  // SETUP NOTIFICATION DETAILS
  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channel_Id',
        'channel_Name',
        channelDescription: 'Daily notification channel',
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  // SHOW NOTIFICATION
  Future<void> showNotification() async {
    return _notificationsPlugin.show(
      0,
      "Notification title",
      "Notification body",
      notificationDetails(),
    );
  }

  // ON TAP
}
