import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_service_app/features/authentication/controllers/signup_controller.dart';
import 'package:home_service_app/utils/constants/colors.dart';
import 'package:home_service_app/utils/validators/validation.dart';
import 'package:iconsax/iconsax.dart';

class CreateAccount extends StatelessWidget {
  // Colors used for the UI
  static const Color _darkBlue = Color(0xFF153A77);
  static const Color _accent = Color(0xFFE94444);

  const CreateAccount({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Scaffold(
      backgroundColor: _darkBlue,
      appBar: AppBar(
        title: const Text('Create Account'),
        backgroundColor: _darkBlue,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
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
                onPressed: () => Get.back(),
              ),
              const SizedBox(height: 32),
              // Title
              const Text(
                'Where a journey begins',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 48),
              // Form for validation
              Form(
                key: controller.signupFormKey,
                child: Column(
                  children: [
                    // Email Field
                    _buildTextField(
                      label: 'Email',
                      controller: controller.email,
                      validator: (value) => HValidator.validateEmail(value),
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: const Icon(Icons.email, color: Colors.white),
                    ),
                    const SizedBox(height: 24),
                    // Password Field
                    Obx(
                      () => _buildTextField(
                        label: 'Password',
                        controller: controller.password,
                        obscureText: controller.hidePassword.value,
                        validator: (value) =>
                            HValidator.validatePassword(value),
                        prefixIcon:
                            const Icon(Icons.password, color: Colors.white),
                        suffixIcon: IconButton(
                          onPressed: () => controller.hidePassword.value =
                              !controller.hidePassword.value,
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
                    // Confirm Password Field
                    _buildTextField(
                      label: 'Confirm Password',
                      controller: controller.confirmPassword,
                      validator: (value) => HValidator.validateEmptyText(
                          "confirm password", value),
                      prefixIcon:
                          const Icon(Icons.password, color: Colors.white),
                      obscureText: controller.hidePassword.value,
                      suffixIcon: IconButton(
                        onPressed: () => controller.hidePassword.value =
                            !controller.hidePassword.value,
                        icon: Icon(
                          controller.hidePassword.value
                              ? Iconsax.eye_slash
                              : Iconsax.eye,
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 48),
              // Create Account Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () async {
                    if (controller.password.text !=
                        controller.confirmPassword.text) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Passwords do not match")),
                      );
                      return;
                    }

                    controller.signup();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: const Text(
                    'Create an account',
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
