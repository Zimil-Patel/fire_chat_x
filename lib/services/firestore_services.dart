import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_chat_x/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireStoreServices {
  FireStoreServices._instance();

  static final FireStoreServices fireStoreServices =
      FireStoreServices._instance();

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> addUser() async {
    User? user = AuthServices.user!;
    try {
      await _firebaseFirestore
          .collection("users")
          .doc("${user.email}")
          .collection("profile")
          .doc("info")
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
}
