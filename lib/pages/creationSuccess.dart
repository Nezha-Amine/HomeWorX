// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class CreationSuccess extends StatelessWidget {
  const CreationSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF153A77), // Background color
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Logo, Image, and Title
              const Column(
                children: [
                  SizedBox(height: 20),
                  // Add an image here
                  Image(
                    image: AssetImage(
                        'assets/images/home_workss.jpg'), // Replace with your asset path
                    height: 120,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Welcome Back !',
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
                      'You have successfully reset and created a new password',
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
                  // "Continue to Home Page" Button
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to Home Page
                      Navigator.pushNamed(context, '/');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      minimumSize: const Size(280, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Continue to the home page',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
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
