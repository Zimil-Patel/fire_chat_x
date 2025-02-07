import 'package:fire_chat_x/services/auth_services.dart';
import 'package:fire_chat_x/services/firestore_services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'dart:developer';

class AppLifecycleController extends GetxController
    with WidgetsBindingObserver {
  @override
  Future<void> onInit() async {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    await setActiveStatus(true);
    log("App Started");
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    log("App Lifecycle State: $state");

    if (state == AppLifecycleState.resumed) {
      await setActiveStatus(true);
      log("✅ App Resumed");
    } else if (state == AppLifecycleState.inactive) {
      await setActiveStatus(false);
      log("⏸️ App Inactive");
    } else if (state == AppLifecycleState.paused) {
      await setActiveStatus(false);
      log("🔴 App Paused");
    } else if (state == AppLifecycleState.detached) {
      await setActiveStatus(false);
      log("🛑 App Detached");
    }
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  setActiveStatus(bool status) async {
    if (AuthServices.authServices.getCurrentUser() != null) {
      await FireStoreServices.fireStoreServices.setIsActiveStatus(status, AuthServices.authServices.getCurrentUser()!.email!);
    }
  }
}
