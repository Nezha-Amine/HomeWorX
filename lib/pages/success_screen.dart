import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'login.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  static double screenWidth() {
    return MediaQuery.of(Get.context!).size.width;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF153A77), // Background color
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 56.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image Animation
              SizedBox(
                width: screenWidth(),
                child: Lottie.asset(
                  'assets/animations/successfully_done.json',
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 32),
              // Title
              const Text(
                'Account Verified!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              // Subtitle
              const Text(
                'Your email has been successfully verified. You can now proceed to use the app.',
                textAlign: TextAlign.center,
                style: TextStyle(
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
                    // Navigate to the login screen
                    Get.offAll(
                      Login(),
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
            ],
          ),
        ),
      ),
    );
  }
}
