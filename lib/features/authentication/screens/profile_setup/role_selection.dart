import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_service_app/features/authentication/screens/profile_setup/client_form.dart';
import 'package:home_service_app/features/authentication/screens/profile_setup/worker_form.dart';
import 'package:home_service_app/utils/constants/colors.dart';

class RoleSelectionPage extends StatelessWidget {
  const RoleSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              const Text(
                'Choose your role',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              const Text(
                'Select how you want to use the app',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 60),

              // Client Role Card
              _buildRoleCard(
                context,
                title: 'Regular Client',
                description:
                    'Find and hire skilled professionals for your needs',
                icon: Icons.person_outline,
                onTap: () =>
                    _setRoleAndNavigate('client', const ClientProfile()),
              ),

              const SizedBox(height: 20),

              // Worker Role Card
              _buildRoleCard(
                context,
                title: 'Service Provider',
                description: 'Offer your services and connect with clients',
                icon: Icons.work_outline,
                onTap: () => _setRoleAndNavigate('worker', const WorkerForm()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _setRoleAndNavigate(String role, Widget destination) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId != null) {
      final userRef =
          FirebaseFirestore.instance.collection('Users').doc(userId);

      try {
        await userRef.update({'role': role});
        Get.off(() => destination);
      } catch (e) {
        print('Error updating role: $e');
      }
    }
  }

  Widget _buildRoleCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required VoidCallback onTap,
    bool isPrimary = true,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isPrimary ? HColors.primary : Colors.white,
          border: isPrimary ? null : Border.all(color: HColors.buttonPrimary),
          borderRadius: BorderRadius.circular(16),
          boxShadow: isPrimary
              ? [
                  BoxShadow(
                    color: HColors.primary.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isPrimary
                    ? Colors.white.withOpacity(0.2)
                    : HColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                size: 32,
                color: isPrimary ? Colors.white : Colors.deepPurple,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isPrimary ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: isPrimary
                          ? Colors.white.withOpacity(0.8)
                          : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: isPrimary ? Colors.white : HColors.primary,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
