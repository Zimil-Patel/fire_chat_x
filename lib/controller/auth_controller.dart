import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../model/country_code.dart';
import '../services/json_service.dart';

class AuthController extends GetxController {
  var emailCtrl = TextEditingController();
  var passCtrl = TextEditingController();
  var segmentValue = 'email'.obs;
  var hidePass = true.obs;
  var isSignedIn = false.obs;
  RxList<CountryCode> countryCodeList = <CountryCode>[].obs;

  // CLEAR ALL CONTROLLERS
  void clearCtrl() {
    emailCtrl.clear();
    passCtrl.clear();
  }

  // GET LOGIN STATUS FROM LOCAL STORAGE
  void getSignInStatusFromStorage() {
    final storage = GetStorage();
    final bool result = storage.read('isSignedIn') ?? false;
    isSignedIn.value = result;
    log("Got SignInStatus: $isSignedIn");
  }


  // SET LOGIN STATUS TO LOCAL STORAGE ON SIGN IN / SIGN OUT
  Future<void> setSignInStatusInStorage(bool value) async {
    final storage = GetStorage();
    try {
      await storage.write('isSignedIn', value);
      isSignedIn.value = value;
      log("SingInStatus set to: $isSignedIn");
    } catch (e) {
      log("Storing failed: $e");
    }
  }


  // GET COUNTRY CODE LIST
  Future<void> getCountryCodeList() async {
    var result = await JsonService.jsonService.getFromJson('country_code');
    if(result != 'failed'){
      countryCodeList.value = (result["countries"] as List).map((e) => CountryCode.fromJson(e)).toList();
      log("Got country code list");
    } else {
      log("Can't get list of country code");
    }
  }

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    await getCountryCodeList();
    super.onInit();
  }
}
