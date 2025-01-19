// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_service_app/pages/create_account.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF153A77), // Background color
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Image, Logo, and Title
              const Column(
                children: [
                  SizedBox(height: 20),
                  // Add an image here
                  Image(
                    image: AssetImage(
                        'assets/images/home_workss.jpg'), // Replace with your asset path
                    height: 150, // Adjust height as needed
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Your home,\nOur work.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Your home deserves the best care, and our experts ensure it’s done right.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ],
              ),
              // Buttons
              Column(
                children: [
                  // "Create New Account" Button
                  ElevatedButton(
                    onPressed: () {
                      Get.to(
                        CreateAccount(),
                        transition: Transition.fadeIn, // Smooth fade transition
                        duration: Duration(milliseconds: 300),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      minimumSize: const Size(280, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'CREATE NEW ACCOUNT',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  // "Already Have an Account" Button
                  OutlinedButton(
                    onPressed: () {
                      // Navigate to Login Page
                      Navigator.pushNamed(context, '/login');
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFD1C4E9)),
                      minimumSize: const Size(280, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'I ALREADY HAVE AN ACCOUNT',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF7E57C2),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
