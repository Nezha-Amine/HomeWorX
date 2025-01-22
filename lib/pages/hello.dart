import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_service_app/data/repositories/authentication/authentication_repository.dart';

import 'package:home_service_app/features/authentication/screens/login/login.dart';

class HelloUserScreen extends StatelessWidget {
  const HelloUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome"),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () async {
              try {
                // Call the logout function
                await AuthenticationRepository.instance.logout();
                // Navigate to the login screen
                Get.offAll(() => const Login());
              } catch (e) {
                // Display error if logout fails
                Get.snackbar(
                  'Logout Failed',
                  e.toString(),
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
              }
            },
          ),
        ],
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Hello, User!",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Welcome to your app!",
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: HelloUserScreen(),
  ));
}
