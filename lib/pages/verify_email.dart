import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:home_service_app/pages/create_account.dart';
import 'package:home_service_app/pages/success_screen.dart';
import 'package:lottie/lottie.dart';

class VerifyEmailScreen extends StatelessWidget {
  final String email; // Email passed from CreateAccount
  const VerifyEmailScreen({super.key, required this.email});

  static double screenWidth() {
    return MediaQuery.of(Get.context!).size.width;
  }

  static const Color _darkBlue = Color(0xFF153A77);
  static const Color _accent = Color(0xFFE94444);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _darkBlue,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: _darkBlue,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => Get.offAll(() => CreateAccount()),
            icon: const Icon(CupertinoIcons.clear, color: Colors.white),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              // Image Animation
              SizedBox(
                width: screenWidth(),
                child: Lottie.asset(
                  'assets/animations/sending_mail_animation.json',
                  fit: BoxFit.contain,
                ),
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
                'We’ve sent an email to $email.\nPlease verify your account to finish registration.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 40),
              // "Continue" Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to the next screen
                    Get.to(
                      SuccessScreen(),
                      transition: Transition.fadeIn,
                      duration: const Duration(milliseconds: 300),
                    );
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
              const SizedBox(height: 16),
              // "Resend Email" Link
              TextButton(
                onPressed: () {
                  // Resend email logic
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
