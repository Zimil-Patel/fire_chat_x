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

  setReceiver(UserModel receiver) {
    this.receiver = receiver;
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

      msgCtrl.clear();

      // Keep the focus on the TextField
      focusNode.requestFocus();
    }
  }

  Future<void> updateMessage(String sender) async {
    final message = msgCtrl.text.trim();
    if (message.isNotEmpty) {
      await FireStoreServices.fireStoreServices.updateChat(
        message: message, sender: sender, receiver: receiver!.email, id: selectedMsgId,);
      msgCtrl.clear();
    } else {
      showSaveButton.value = false;
    }
    }

    @override
    void onClose() {
      // Dispose of controllers and focus node
      msgCtrl.dispose();
      focusNode.dispose();
      super.onClose();
    }
  }