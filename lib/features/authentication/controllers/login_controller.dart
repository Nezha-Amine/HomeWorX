import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:home_service_app/data/repositories/authentication/authentication_repository.dart';
import 'package:home_service_app/utils/constants/image_strings.dart';
import 'package:home_service_app/utils/helpers/network_manager.dart';
import 'package:home_service_app/utils/popups/full_screen_loader.dart';
import 'package:home_service_app/utils/popups/loaders.dart';

class LoginController extends GetxController {
  //Variables
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  //Email and password SignIn

  Future<void> emailAndPasswordSignIn() async {
    try {
      // Start loading
      HFullScreenLoader.openLoadingDialog(
          'Logging you in ....', HImages.docerAnimation);

      // Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        HFullScreenLoader.stopLoading();
        return;
      }

      // Form validation
      if (!loginFormKey.currentState!.validate()) {
        HFullScreenLoader.stopLoading();
        return;
      }

      // Save data if rememberMe is selected
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      // Login user with email and password authentication
      await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      // Redirect to the appropriate screen
      await AuthenticationRepository.instance.screenRedirect();

      // Remove loader
      HFullScreenLoader.stopLoading();
    } catch (e) {
      HFullScreenLoader.stopLoading();
      HLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
