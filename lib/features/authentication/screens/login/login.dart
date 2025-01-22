// ignore_for_file: prefer_const_constructors, use_super_parameters, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_service_app/features/authentication/controllers/login_controller.dart';
import 'package:home_service_app/features/authentication/screens/password_configuration/forgetPassword.dart';
import 'package:home_service_app/pages/home.dart';
import 'package:home_service_app/utils/validators/validation.dart';
import 'package:iconsax/iconsax.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Scaffold(
      backgroundColor: const Color(0xFF153A77),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: controller.loginFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back Button
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 28,
                  ),
                  onPressed: () => Get.offAll(() => Home()),
                ),
                const SizedBox(height: 32),

                // Greeting Text
                Row(
                  children: const [
                    Text(
                      'Hello there comrade',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      '👋',
                      style: TextStyle(fontSize: 32),
                    ),
                  ],
                ),
                const SizedBox(height: 48),

                // Email Field
                _buildTextField(
                  label: 'Email',
                  controller: controller.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: HValidator.validateEmail,
                  prefixIcon: const Icon(Icons.email, color: Colors.white),
                ),
                const SizedBox(height: 24),

                // Password Field
                Obx(
                  () => _buildTextField(
                    label: 'Password',
                    controller: controller.password,
                    obscureText: controller.hidePassword.value,
                    validator: HValidator.validatePassword,
                    prefixIcon: const Icon(Icons.password, color: Colors.white),
                    suffixIcon: IconButton(
                      onPressed: () => controller.hidePassword.toggle(),
                      icon: Icon(
                        controller.hidePassword.value
                            ? Iconsax.eye_slash
                            : Iconsax.eye,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Remember Me Checkbox
                Obx(
                  () => Row(
                    children: [
                      Checkbox(
                        value: controller.rememberMe.value,
                        onChanged: (value) => controller.rememberMe.toggle(),
                        fillColor:
                            MaterialStateProperty.all(const Color(0xFFE94444)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const Text(
                        'Remember me',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Forgot Password Button
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(ForgetPassword());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF153A77),
                      minimumSize: const Size(280, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Forgot password',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // Sign In Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.emailAndPasswordSignIn();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                    child: const Text(
                      'Sign in',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method for creating text fields
  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    TextInputType? keyboardType,
    bool obscureText = false,
    String? Function(String?)? validator,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          style: const TextStyle(color: Colors.white),
          validator: validator,
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blueAccent),
            ),
          ),
        ),
      ],
    );
  }
}
