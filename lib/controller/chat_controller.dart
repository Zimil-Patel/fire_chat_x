import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_chat_x/model/user_model.dart';
import 'package:fire_chat_x/services/api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../model/chat_model.dart';
import '../services/firestore_services.dart';

class ChatController extends GetxController {
  UserModel? receiver;
  TextEditingController msgCtrl = TextEditingController();
  FocusNode focusNode = FocusNode();
  RxBool showSaveButton = false.obs;
  String selectedMsgId = "";
  ScrollController scrollController = ScrollController();
  String imgUrl = "";

  setReceiver(UserModel receiver) {
    this.receiver = receiver;
  }

  void scrollToEnd() {
    log("Called scroll to end...");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> sendMessage(String sender) async {
    final message = msgCtrl.text.trim();
    if (message.isNotEmpty) {
      ChatModel chat = ChatModel(
        message: msgCtrl.text,
        sender: sender,
        receiver: receiver!.email!,
        time: Timestamp.now(),
      );

      msgCtrl.clear();
      await FireStoreServices.fireStoreServices.sendChat(chat);

      // Keep the focus on the TextField
      focusNode.requestFocus();
      scrollToEnd();
    }
  }

  Future<void> updateMessage(String sender) async {
    final message = msgCtrl.text.trim();
    if (message.isNotEmpty) {
      showSaveButton.value = false;
      msgCtrl.clear();
      await FireStoreServices.fireStoreServices.updateChat(
        message: message,
        sender: sender,
        receiver: receiver!.email,
        id: selectedMsgId,
      );
    } else {
      showSaveButton.value = false;
    }
    scrollToEnd();
  }

  Future<void> pickImage(ImageSource source, String sender) async {
    ImagePicker picker = ImagePicker();
    XFile? imageFile = await picker.pickImage(source: source);
    if (imageFile != null) {
      final byteImage = await imageFile.readAsBytes();
      final imgUrl = await ApiServices.apiServices.postImage(byteImage) ?? "";
      if (imgUrl.isNotEmpty) {
        ChatModel chat = ChatModel(
          message: imgUrl,
          isImage: true,
          sender: sender,
          receiver: receiver!.email!,
          time: Timestamp.now(),
        );
        await FireStoreServices.fireStoreServices.sendChat(chat);

      } else {
        log("Url is empty!!!");
      }
    }
  }

  Future<void> updateImage(ImageSource source, ChatModel chat) async {
    ImagePicker picker = ImagePicker();
    XFile? imageFile = await picker.pickImage(source: source);
    if (imageFile != null){
      final byteImage = await imageFile.readAsBytes();
      final imgUrl = await ApiServices.apiServices.postImage(byteImage) ?? "";
      log(chat.sender + chat.receiver);
      await FireStoreServices.fireStoreServices.updateChat(message: imgUrl, sender: chat.sender, receiver: receiver!.email, id: chat.chatId);
    } else {
      log("Url is empty!!!");
    }
  }

  @override
  void onClose() {
    // Dispose of controllers and focus node
    log("disposing");
    msgCtrl.dispose();
    focusNode.dispose();
    scrollController.dispose();
    super.onClose();
  }
}
