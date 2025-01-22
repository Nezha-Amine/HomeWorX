import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_service_app/data/repositories/authentication/authentication_repository.dart';
import 'package:home_service_app/features/authentication/screens/password_configuration/forgetPassword.dart';
import 'package:home_service_app/features/authentication/screens/password_configuration/resetPassword.dart';
import 'package:home_service_app/utils/constants/image_strings.dart';
import 'package:home_service_app/utils/helpers/network_manager.dart';
import 'package:home_service_app/utils/popups/full_screen_loader.dart';
import 'package:home_service_app/utils/popups/loaders.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  //variables
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  //send reset password email
  sendPasswordResetEmail() async {
    try {
      //start loading
      HFullScreenLoader.openLoadingDialog(
          'Processing your request ....', HImages.docerAnimation);

      //check internet connectivity

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        HFullScreenLoader.stopLoading();
        return;
      }

      //form validation
      if (!forgetPasswordFormKey.currentState!.validate()) {
        HFullScreenLoader.stopLoading();
        return;
      }

      //send email to reset password
      await AuthenticationRepository.instance
          .sendPasswordResetEmail(email.text.trim());
      //remove loader
      HFullScreenLoader.stopLoading();
      //show success screen

      HLoaders.successSnackBar(
          title: 'Email Sent!',
          message: "Email Link Sent to Reset your Password".tr);

      Get.to(() => ResetPassword(email: email.text.trim()));
    } catch (e) {
      HFullScreenLoader.stopLoading();
      HLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  resendPasswordResetEmail(String email) async {
    try {
      //start loading
      HFullScreenLoader.openLoadingDialog(
          'Processing your request ....', HImages.docerAnimation);

      //check internet connectivity

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        HFullScreenLoader.stopLoading();
        return;
      }

      //send email to reset password
      await AuthenticationRepository.instance.sendPasswordResetEmail(email);
      //remove loader
      HFullScreenLoader.stopLoading();
      //show success screen

      HLoaders.successSnackBar(
          title: 'Email Sent!',
          message: "Email Link Sent to Reset your Password".tr);
    } catch (e) {
      HFullScreenLoader.stopLoading();
      HLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
