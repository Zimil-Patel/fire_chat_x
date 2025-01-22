import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_chat_x/model/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../model/chat_model.dart';
import '../services/firestore_services.dart';

class ChatController extends GetxController {

  UserModel? receiver;
  TextEditingController msgCtrl = TextEditingController();
  FocusNode focusNode = FocusNode();
  RxBool showSaveButton = false.obs;
  String selectedMsgId = "";
  ScrollController scrollController = ScrollController();

  setReceiver(UserModel receiver) {
    this.receiver = receiver;
  }

  void scrollToEnd(){
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

      await FireStoreServices.fireStoreServices.sendChat(chat);

      // Keep the focus on the TextField
      focusNode.requestFocus();
      msgCtrl.clear();
      scrollToEnd();

    }
  }

  Future<void> updateMessage(String sender) async {
    final message = msgCtrl.text.trim();
    if (message.isNotEmpty) {
      showSaveButton.value = false;
      msgCtrl.clear();
      await FireStoreServices.fireStoreServices.updateChat(
        message: message, sender: sender, receiver: receiver!.email, id: selectedMsgId,);
    } else {
      showSaveButton.value = false;
    }
    scrollToEnd();
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