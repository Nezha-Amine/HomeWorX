import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_service_app/features/authentication/controllers/forget_password_controller.dart';
import 'package:home_service_app/features/authentication/controllers/verify_email_controller.dart';
import 'package:home_service_app/features/authentication/screens/login/login.dart';
import 'package:lottie/lottie.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key, required this.email});
  final String email;

  static const Color _darkBlue = Color(0xFF153A77);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());
    return Scaffold(
      backgroundColor: _darkBlue,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animation
              Lottie.asset(
                'assets/images/animations/sending_mail_animation.json',
                width: MediaQuery.of(context).size.width,
              ),
              const SizedBox(height: 32),

              // Title
              const Text(
                'Check your email',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),

              // Subtitle
              Text(
                'We’ve sent a reset link to $email.\nPlease check your email to proceed.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to the login screen
                    Get.offAll(() => const Login());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // Resend Email Button
              TextButton(
                onPressed: () {
                  ForgetPasswordController.instance
                      .resendPasswordResetEmail(email);
                },
                child: const Text(
                  'Resend Email',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.lightBlueAccent,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
