import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_chat_x/model/chat_model.dart';
import 'package:fire_chat_x/model/user_model.dart';
import 'package:fire_chat_x/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireStoreServices {
  FireStoreServices._instance();

  static final FireStoreServices fireStoreServices =
      FireStoreServices._instance();

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  // ADD USER TO FIRE STORE
  Future<void> addUser(UserModel user) async {
    try {
      await _fireStore.collection("users").doc("${user.email}").set({
        "email": user.email,
        "phone": user.phoneNumber,
        "displayName": user.displayName,
        "photoURL": user.photoURL,
      });

      log("Added successfully...");
    } catch (e) {
      log("Failed to add: $e");
    }
  }

  // GET CURRENT USER DETAIL FROM FIRE STORE
  Future<UserModel?> getCurrentUserInfo() async {
    User? user = AuthServices.user!;
    try {
      DocumentSnapshot snapshot =
          await _fireStore.collection('users').doc(user.email).get();
      final data = snapshot.data() as Map<String, dynamic>;
      UserModel result = UserModel.fromFireStore(data);
      return result;
    } catch (e) {
      log("Failed to get user info: $e");
    }

    return null;
  }

  // GET ALL USERS LIST
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>?>
      getFireStoreUsersList() async {
    try {
      final userList = await _fireStore
          .collection('users')
          .get()
          .then((value) => value.docs);

      return userList;
    } catch (e) {
      log("Failed to get user info: $e");
    }

    return null;
  }

  // CHAT SERVICES
  DocumentReference<Object?> getDocReference(String sender, receiver) {
    List chatUsers = [sender, receiver];
    chatUsers.sort();
    String docId = chatUsers.join("-");

    DocumentReference chatReference = _fireStore.collection("chats").doc(docId);

    return chatReference;
  }

  // SEND MESSAGE / ADD MESSAGE TO FIREBASE
  Future<void> sendChat(ChatModel chat) async {
    DocumentReference reference = getDocReference(chat.sender, chat.receiver);


    try {
      await reference.collection('messages').add({
        "sender": chat.sender,
        "receiver": chat.receiver,
        "message": chat.message,
        "time": chat.time
      });
    } catch (e) {
      log("Failed to send chat!!! : $e");
    }
  }


  // GET CHATS
  Stream<List<ChatModel>> getChats(String sender, String receiver) {
    DocumentReference reference = getDocReference(sender, receiver);

    // Return a stream of ChatModel lists
    return reference
        .collection('messages')
        .orderBy('time', descending: false)
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs.map((snapshot) {
      return ChatModel.fromFirebase(snapshot.data());
    }).toList());
  }

}
