import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:home_service_app/features/authentication/screens/client_home_page.dart';
import 'package:home_service_app/features/authentication/screens/login/login.dart';
import 'package:home_service_app/features/authentication/screens/onboarding/onboarding.dart';
import 'package:home_service_app/features/authentication/screens/profile_setup/role_selection.dart';
import 'package:home_service_app/features/authentication/screens/profile_setup/worker_form.dart';
import 'package:home_service_app/features/authentication/screens/signup/verify_email.dart';
import 'package:home_service_app/features/authentication/screens/worker_home_page.dart';
import 'package:home_service_app/pages/hello.dart';
import 'package:home_service_app/pages/home.dart';
import 'package:home_service_app/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:home_service_app/utils/exceptions/firebase_exceptions.dart';
import 'package:home_service_app/utils/exceptions/format_exceptions.dart';
import 'package:home_service_app/utils/exceptions/platform_exceptions.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  //Variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  //Called from main.dart on app launch
  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  //Function to show Relevant Screen
  screenRedirect() async {
    User? user = _auth.currentUser;
    if (user != null) {
      if (user.emailVerified) {
        // Fetch user data from Firestore
        var userDoc = await FirebaseFirestore.instance
            .collection('Users')
            .doc(user.uid)
            .get();

        if (userDoc.exists && userDoc.data()?['role'] != null) {
          // Check the role and ensure the profile is complete
          String role = userDoc.data()?['role'];
          if (role == 'client' || role == 'worker') {
            // Check if the profile is complete
            bool isProfileComplete = userDoc.data()?['first_name'] != null &&
                userDoc.data()?['last_name'] != null &&
                userDoc.data()?['phone'] != null &&
                userDoc.data()?['address'] != null;

            if (role == 'worker') {
              isProfileComplete = isProfileComplete &&
                  userDoc.data()?['experience'] != null &&
                  userDoc.data()?['hourly_rate'] != null &&
                  userDoc.data()?['service'] != null;
            }

            if (isProfileComplete) {
              // Redirect based on role
              if (role == 'client') {
                Get.offAll(() => const ClientHomePage());
              } else if (role == 'worker') {
                Get.offAll(() => const WorkerHomePage());
              }
            } else {
              // Redirect to profile setup page
              Get.offAll(() =>
                  const WorkerForm()); // Change to the appropriate setup page
            }
          } else {
            // Handle case where role is undefined
            Get.offAll(() => const RoleSelectionPage());
          }
        } else {
          // No user data found
          Get.offAll(() => const RoleSelectionPage());
        }
      } else {
        Get.offAll(() => VerifyEmailScreen(email: _auth.currentUser?.email));
      }
    } else {
      deviceStorage.writeIfNull('IsFirstTime', true);
      deviceStorage.read('IsFirstTime') != true
          ? Get.offAll(() => const Home())
          : Get.offAll(const OnBoardingScreen());
    }
  }

  //[EmailAuthentication] - SingIn

  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw HFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw HFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const HFormatException();
    } on PlatformException catch (e) {
      throw HPlatformException(e.code).message;
    } catch (e) {
      throw ' Something went wrong.Please try again';
    }
  }

  //[EmailAuthentication] - Register
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      // Add user to Firestore with a null role
      await FirebaseFirestore.instance
          .collection('Users') // Use 'Users' collection
          .doc(userCredential.user?.uid)
          .set({
        "id": userCredential.user?.uid,
        "email": email,
        "role": null, // Initially null
      });

      return userCredential;
    } catch (e) {
      // Error handling remains the same
      rethrow;
    }
  }

  //[EmailVerification] - Mail Verification
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw HFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw HFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const HFormatException();
    } on PlatformException catch (e) {
      throw HPlatformException(e.code).message;
    } catch (e) {
      throw ' Something went wrong.Please try again';
    }
  }

  //[ReAuthenticate] - ReAuthenticate User

  //[EmailAuthentication] - Forget Password
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw HFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw HFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const HFormatException();
    } on PlatformException catch (e) {
      throw HPlatformException(e.code).message;
    } catch (e) {
      throw ' Something went wrong.Please try again';
    }
  }

  //LogoutUser
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      throw HFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw HFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const HFormatException();
    } on PlatformException catch (e) {
      throw HPlatformException(e.code).message;
    } catch (e) {
      throw ' Something went wrong.Please try again';
    }
  }

  // Delete User - remove user auth and firestore account
}
