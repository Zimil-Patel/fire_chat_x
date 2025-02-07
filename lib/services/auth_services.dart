import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_chat_x/main.dart';
import 'package:fire_chat_x/model/user_model.dart';
import 'package:fire_chat_x/services/firestore_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  AuthServices._instance();
  static final AuthServices authServices = AuthServices._instance();
  static User? user;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // SIGN UP USING EMAIL / PASS
  Future<bool> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      UserCredential credential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      log("Successfully created... ${credential.user!.email}");
      UserModel details = UserModel(
        email: credential.user!.email,
      );
      FireStoreServices.fireStoreServices.addUser(details);
      return true;
    } catch (e) {
      log("Failed to create user!!! : $e");
    }
    return false;
  }

  // SIGN IN USING EMAIL / PASS
  Future<bool> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
      await FireStoreServices.fireStoreServices.setIsActiveStatus(true, user!.email!);
      log("Successfully singed in... ${userCredential.user!.email}");

      return true;
    } catch (e) {
      log("Sign in failed !!! : $e");
    }
    return false;
  }

  // SIGN OUT
  Future<void> singOutUser() async {
    try {
      if (getCurrentUser() != null) {
        await FireStoreServices.fireStoreServices.setIsActiveStatus(false, AuthServices.authServices.getCurrentUser()!.email!);
        await _firebaseAuth.signOut();
        await GoogleSignIn().signOut();
        user = null;
        authController.setSignInStatusInStorage(false);
        log("Signed out...");
      } else {
        log("Current user is null");
      }
    } catch (e) {
      log("Sign out failed!!! : $e");
    }
  }

  // CURRENT USER
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  // SIGN IN WITH GOOGLE
  Future<bool> signInWithGoogle() async {
    if (getCurrentUser() != null) {
      log("Sign out for google sign in");
      _firebaseAuth.signOut();
    }

    try{
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? signInAccount = await googleSignIn.signIn();
      final GoogleSignInAuthentication? signInAuth =
      await signInAccount?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: signInAuth?.accessToken,
        idToken: signInAuth?.idToken,
      );

      try {
        await _firebaseAuth.signInWithCredential(credential);
        if (getCurrentUser() != null) {
          user = getCurrentUser();
          log("Logged in as ${getCurrentUser()!.email!}");

          final userDoc = FirebaseFirestore.instance.collection('users').doc(user!.email);
          DocumentSnapshot snapshot = await userDoc.get();

          if(snapshot.exists){
            // update status only is already user exists
            await FireStoreServices.fireStoreServices.setIsActiveStatus(true, user!.email!);
          } else {
            // add new user to users collection
            UserModel details = UserModel(
              email: user!.email,
              displayName: user!.displayName,
              phoneNumber: user!.phoneNumber,
              photoURL: user!.photoURL,
            );
            await FireStoreServices.fireStoreServices.addUser(details);
          }


          return true;
        }
      } catch (e) {
        log("Failed: ${e.toString()}");
      }

    } catch(e) {
      log("Error: $e");
    }
    return false;
  }

}
