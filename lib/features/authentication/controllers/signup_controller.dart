import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_service_app/data/repositories/authentication/authentication_repository.dart';
import 'package:home_service_app/data/repositories/user/user_repository.dart';
import 'package:home_service_app/features/authentication/models/user_model.dart';
import 'package:home_service_app/features/authentication/screens/signup/verify_email.dart';
import 'package:home_service_app/utils/constants/image_strings.dart';
import 'package:home_service_app/utils/helpers/network_manager.dart';
import 'package:home_service_app/utils/popups/full_screen_loader.dart';
import 'package:home_service_app/utils/popups/loaders.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final hidePassword = true.obs;
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  final _authRepository = AuthenticationRepository.instance;
  final _userRepository = UserRepository.instance;

  void signup() async {
    try {
      HFullScreenLoader.openLoadingDialog(
          "We're processing your information ...", HImages.docerAnimation);
      //check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        HFullScreenLoader.stopLoading();
        return;
      }

      //form validation
      if (!signupFormKey.currentState!.validate()) {
        HFullScreenLoader.stopLoading();
        return;
      }

      // Register user in Firebase Authentication
      final userCredential = await _authRepository.registerWithEmailAndPassword(
        email.text.trim(),
        password.text.trim(),
      );

      // Save authenticated user data in Firestore
      final newUser = UserModel(
        id: userCredential.user!.uid,
        email: email.text.trim(),
      );

      await _userRepository.saveUserRecord(newUser);

      HFullScreenLoader.stopLoading();

      // Show success message
      HLoaders.successSnackBar(
          title: "Congrats",
          message: 'Your account has been created! Verify email to continue.');

      // Navigate to verify email screen
      Get.to(() => VerifyEmailScreen(email: email.text.trim()));
    } catch (e) {
      HFullScreenLoader.stopLoading();
      HLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
