import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final String chatId;
  final String message, sender, receiver;
  final Timestamp time;
  final bool isImage, isSeen;

  ChatModel({
    this.chatId = "null",
    required this.message,
    required this.sender,
    required this.receiver,
    required this.time,
    this.isImage = false,
    this.isSeen = false,
  });

  factory ChatModel.fromFirebase(Map map, String chatId) => ChatModel(
        chatId: chatId,
        message: map['message'],
        sender: map['sender'],
        receiver: map['receiver'],
        time: map['time'],
        isImage: map['isImage'] ?? false,
        isSeen: map['isSeen'] ?? false,
      );
}
