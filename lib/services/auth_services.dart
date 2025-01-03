import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  AuthServices._instance();

  static final AuthServices authServices = AuthServices._instance();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // SIGN UP USING EMAIL / PASS
  Future<bool> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      UserCredential credential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      log("Successfully created... ${credential.user}");
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
      log("Successfully singed in... ${userCredential.user}");
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
        await _firebaseAuth.signOut();
        await GoogleSignIn().signOut();
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
          log("Logged in as ${getCurrentUser()!.email!}");
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
