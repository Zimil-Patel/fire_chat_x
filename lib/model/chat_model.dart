import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final String message, sender, receiver;
  final Timestamp time;

  ChatModel(
      {required this.message,
      required this.sender,
      required this.receiver,
      required this.time});

  factory ChatModel.fromFirebase(Map map) => ChatModel(
        message: map['message'],
        sender: map['sender'],
        receiver: map['receiver'],
        time: map['time'],
      );
}
