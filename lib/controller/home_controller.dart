import 'dart:developer';

import 'package:get/get.dart';

import '../model/user_model.dart';
import '../services/firestore_services.dart';

class HomeController extends GetxController{

  UserModel? currentUser;

  // GET CURRENT USER
  Future<UserModel?> setCurrentUser() async {
    currentUser = await FireStoreServices.fireStoreServices.getCurrentUserInfo();
    return currentUser;
  }

  @override
  Future<void> onInit() async {
    log("called init");
    await setCurrentUser();
    await FireStoreServices.fireStoreServices.getFireStoreUsersList();
    super.onInit();
  }
}