import 'dart:typed_data';

import 'package:fire_chat_x/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toastification/toastification.dart';

import '../main.dart';
import '../model/user_model.dart';
import '../services/firestore_services.dart';

class HomeController extends GetxController {
  UserModel? currentUser;
  TextEditingController txtName = TextEditingController();
  FocusNode focusNode = FocusNode();

  // GET CURRENT USER
  Future<UserModel?> setCurrentUser() async {
    // log("------ setting current user");
    currentUser =
        await FireStoreServices.fireStoreServices.getCurrentUserInfo();
    if(currentUser != null) homeController.txtName.text = currentUser!.displayName ?? "";
    update();
    return currentUser;
  }

  // PICK IMAGE
  Future<void> pickProfilePictureImage(ImageSource source) async {
    ImagePicker picker = ImagePicker();
    final XFile? file = await picker.pickImage(source: source);

    if (file != null) {
      final Uint8List image = await file.readAsBytes();
      final url = await ApiServices.apiServices.postImage(image);
      if (url != null) {
        await FireStoreServices.fireStoreServices
            .updateUserProfilePicture(url, currentUser!.email);
        await setCurrentUser();
        toastification.show(
          type: ToastificationType.success,
          style: ToastificationStyle.minimal,
          autoCloseDuration: const Duration(seconds: 2),
          title: const Text('Success'),
          description: const Text('Profile photo updated.'),
        );
      }
    }
  }

  // UPDATE DISPLAY NAME
  Future<void> updateDisplayName() async {
    if (txtName.text.isNotEmpty) {
      await FireStoreServices.fireStoreServices
          .updateUserDisplayName(txtName.text, currentUser!.email);

      await setCurrentUser();
      toastification.show(
        type: ToastificationType.success,
        style: ToastificationStyle.minimal,
        autoCloseDuration: const Duration(seconds: 2),
        title: const Text('Success'),
        description: const Text('Display name updated.'),
      );
    }
    if (focusNode.hasFocus) focusNode.unfocus();
  }

  @override
  Future<void> onInit() async {
    // log("called init");
    // await setCurrentUser();
    super.onInit();
  }

  @override
  void onClose() {
    txtName.dispose();
    focusNode.dispose();
    super.onClose();
  }
}
