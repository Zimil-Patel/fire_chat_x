import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
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
      await _fireStore
          .collection("users")
          .doc("${user.email}")
          .set({
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
      DocumentSnapshot snapshot = await _fireStore
          .collection('users')
          .doc(user.email)
          .get();
      final data = snapshot.data() as Map<String, dynamic>;
      UserModel result = UserModel.fromFireStore(data);
      return result;
    } catch (e) {
      log("Failed to get user info: $e");
    }

    return null;
  }

  // GET ALL USERS LIST
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>?> getFireStoreUsersList() async {
    User? user = AuthServices.user!;
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
}
