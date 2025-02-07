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
        "isActive": true,
      });

      log("Added successfully...");
    } catch (e) {
      log("Failed to add: $e");
    }
  }

  // GET CURRENT USER DETAIL FROM FIRE STORE
  Future<UserModel?> getCurrentUserInfo() async {
    User? user = AuthServices.authServices.getCurrentUser();
    try {
      DocumentSnapshot snapshot =
          await _fireStore.collection('users').doc(user!.email).get();
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

  // SET ONLINE OFFLINE STATUS

  // SEND MESSAGE / ADD MESSAGE TO FIREBASE
  Future<void> sendChat(ChatModel chat) async {
    DocumentReference reference = getDocReference(chat.sender, chat.receiver);

    try {
      await reference.collection('messages').add({
        "sender": chat.sender,
        "receiver": chat.receiver,
        "message": chat.message,
        "time": chat.time,
        "isImage": chat.isImage,
        "isSeen": chat.isSeen
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
              return ChatModel.fromFirebase(snapshot.data(), snapshot.id);
            }).toList());
  }

  // MARK MESSAGE AS SEEN
  Future<void> markMessageAsSeen(String sender, receiver) async {
    // log("Making message as seen");
    final reference = getDocReference(sender, receiver);

    final snapshot = await reference
        .collection('messages')
        .where('receiver', isEqualTo: sender)
        .where('isSeen', isEqualTo: false)
        .get();

    for (var doc in snapshot.docs) {
      await doc.reference.update({'isSeen': true});
    }
  }

  // DELETE CHAT
  Future<void> deleteChat(String id, String sender, String receiver) async {
    DocumentReference reference = getDocReference(sender, receiver);

    // DELETE CHAT
    try {
      await reference.collection("messages").doc(id).delete();
      log("Chat deleted successfully");
    } catch (e) {
      log("Chat delete failed");
    }
  }

  // UPDATE CHAT
  Future<void> updateChat(
      {required String message,
      required sender,
      required receiver,
      required id}) async {
    DocumentReference reference = getDocReference(sender, receiver);
    // DELETE CHAT
    try {
      await reference
          .collection("messages")
          .doc(id)
          .update({"message": message});
      log("Chat updated successfully");
    } catch (e) {
      log("Chat update failed");
    }
  }

  // SET IS ACTIVE
  Future<void> setIsActiveStatus(bool status, String userEmail) async {
    await _fireStore
        .collection('users')
        .doc(userEmail)
        .update({'isActive': status});
  }

  // GET IS ACTIVE STATUS
  Stream<DocumentSnapshot<Map<String, dynamic>>> getIsActiveStatus(
      String userEmail) {
    return _fireStore.collection('users').doc(userEmail).snapshots();
  }

  // UPDATE PROFILE PICTURE
  Future<void> updateUserProfilePicture(String url, userEmail) async {
    await _fireStore.collection('users').doc(userEmail).update({"photoURL": url});
  }

  // UPDATE DISPLAY NAME
  Future<void> updateUserDisplayName(String name, userEmail) async {
    await _fireStore.collection('users').doc(userEmail).update({"displayName": name});
  }

}
