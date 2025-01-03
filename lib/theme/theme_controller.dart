import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  @override
  Future<void> onInit() async {
    super.onInit();
    await getTheme();
  }

  RxBool isDark = true.obs;

  // SAVE THEME
  Future<void> saveTheme(bool value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final themeStatus = await pref.setBool('isDark', value);
    log("Theme save status : $themeStatus");
    isDark.value = value;
  }

  // GET THEME
  Future<void> getTheme() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    isDark.value = pref.getBool('isDark') ?? true;
    log("Got theme pref : $isDark");
  }
}
