import 'package:fire_chat_x/model/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {

  UserModel? receiver;
  TextEditingController msgCtrl = TextEditingController();

  setReceiver(UserModel receiver){
    this.receiver = receiver;
  }
}