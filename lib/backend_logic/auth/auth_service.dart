import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  Future<User?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      // Send email verification
      await cred.user?.sendEmailVerification();
      return cred.user;
    } catch (e) {
      log("something went wrong");
    }

    return null;
  }

  Future<User?> loginUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (cred.user?.emailVerified == false) {
        await cred.user?.sendEmailVerification();
        log("Email not verified. Verification email sent.");
        return null;
      }
      return cred.user;
    } catch (e) {
      log("something went wrong");
    }

    return null;
  }

  Future<void> signout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      log("something went wrong");
    }
  }
}
