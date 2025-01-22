import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:home_service_app/features/authentication/models/user_model.dart';
import 'package:home_service_app/utils/exceptions/firebase_exceptions.dart';
import 'package:home_service_app/utils/exceptions/platform_exceptions.dart';

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
}
