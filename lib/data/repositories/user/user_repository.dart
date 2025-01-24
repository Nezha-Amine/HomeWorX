import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:home_service_app/features/authentication/models/user_model.dart';
import 'package:home_service_app/utils/exceptions/firebase_exceptions.dart';
import 'package:home_service_app/utils/exceptions/platform_exceptions.dart';
import 'package:logger/logger.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection("Users").doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      throw HFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw HPlatformException(e.code).message;
    } catch (e) {
      throw 'Failed to save user data: $e';
    }
  }

  Future<void> updateUserServices(
      String userId, List<HandymanService> services) async {
    try {
      final servicesData = services.map((service) => service.toJson()).toList();
      await _db
          .collection("Users")
          .doc(userId)
          .update({"services": servicesData});
    } catch (e) {
      throw 'Failed to update services: $e';
    }
  }

  Future<UserModel?> getUserData(String userId) async {
    try {
      final doc = await _db.collection("Users").doc(userId).get();
      if (doc.exists) {
        return UserModel.fromJson(doc.data()!);
      }
    } catch (e) {
      throw 'Failed to fetch user data: $e';
    }
    return null;
  }

  Future<String> uploadProfilePicture(String userId, File imageFile) async {
    try {
      final ref =
          FirebaseStorage.instance.ref().child('profile_pictures/$userId.png');
      await ref.putFile(imageFile);
      return await ref.getDownloadURL();
    } catch (e) {
      throw 'Failed to upload profile picture: $e';
    }
  }

  final Logger _logger = Logger();

  Future<UserModel?> getAuthenticatedUserData() async {
    final Logger logger = Logger(); // Initialize the logger
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        logger.d('Authenticated user found: ${user.uid}');

        final userData = await getUserData(user.uid);
        if (userData != null) {
          logger.i('User data fetched successfully for user ID: ${user.uid}');
          logger.v('Fetched user data: ${userData.toJson()}');
          return userData;
        } else {
          logger.w('No user data found for user ID: ${user.uid}');
        }
      } else {
        logger.w('No authenticated user found.');
      }
    } catch (e, stackTrace) {
      logger.e('Failed to fetch authenticated user data',
          error: e, stackTrace: stackTrace);
      throw 'Failed to fetch authenticated user data: $e';
    }
    return null;
  }
}
