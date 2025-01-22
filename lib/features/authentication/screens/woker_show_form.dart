import 'package:flutter/material.dart';

class WorkerInfoPage extends StatelessWidget {
  final String fullName;
  final String phone;
  final String email;
  final String experience;
  final String workType;
  final String country;

  const WorkerInfoPage({
    super.key,
    required this.fullName,
    required this.phone,
    required this.email,
    required this.experience,
    required this.workType,
    required this.country,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Worker Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Full Name: $fullName', style: const TextStyle(fontSize: 18)),
            Text('Phone: $phone', style: const TextStyle(fontSize: 18)),
            Text('Email: $email', style: const TextStyle(fontSize: 18)),
            Text('Experience: $experience years',
                style: const TextStyle(fontSize: 18)),
            Text('Work Type: $workType', style: const TextStyle(fontSize: 18)),
            Text('Country: $country', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 32), // Add some space before the button
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/role_selec');
              },
              child: const Text('Back to Role Selection'),
            ),
          ],
        ),
      ),
    );
  }
}

class RoleSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Role Selection'),
      ),
      body: Center(
        child: const Text('Role Selection Page'),
      ),
    );
  }
}
