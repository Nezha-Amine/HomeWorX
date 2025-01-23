import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_service_app/data/repositories/user/user_repository.dart';
import 'package:home_service_app/features/authentication/models/user_model.dart';
import 'package:home_service_app/features/authentication/screens/worker_home_page.dart';

class WorkerForm extends StatefulWidget {
  const WorkerForm({super.key});

  @override
  State<WorkerForm> createState() => _WorkerRegistrationFlowState();
}

class _WorkerRegistrationFlowState extends State<WorkerForm> {
  int _currentStep = 0;
  final _formKey = GlobalKey<FormState>();

  // Use separate controllers for first and last name
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  String? _selectedWorkType;
  String? _hourlyRate;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    _emailController.text = user?.email ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Become a Worker',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
      body: _currentStep == 0
          ? _buildWelcomeScreen()
          : _currentStep == 1
              ? _buildRegistrationForm()
              : _currentStep == 2
                  ? _buildWorkTypeSelection()
                  : _currentStep == 3
                      ? _buildHourlyRateSelection()
                      : _buildSuccessScreen(),
    );
  }

  // Step 1: Registration Form (Updated for first name and last name)
  Widget _buildRegistrationForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // First Name Field
            _buildTextField(
              controller: _firstNameController,
              label: 'First Name',
              validator: (value) => value?.isEmpty ?? true
                  ? 'Please enter your first name'
                  : null,
            ),
            const SizedBox(height: 16),
            // Last Name Field
            _buildTextField(
              controller: _lastNameController,
              label: 'Last Name',
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Please enter your last name' : null,
            ),
            const SizedBox(height: 16),
            // Phone Number Field
            _buildTextField(
              controller: _phoneController,
              label: 'Phone Number',
              keyboardType: TextInputType.phone,
              validator: (value) => value?.isEmpty ?? true
                  ? 'Please enter your phone number'
                  : null,
            ),
            const SizedBox(height: 16),
            // Email Address Field
            _buildTextField(
              controller: _emailController,
              label: 'Email Address',
              keyboardType: TextInputType.emailAddress,
              readOnly: true,
              // Make the field non-editable
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Please enter your email' : null,
            ),
            const SizedBox(height: 16),
            // Experience Field
            _buildTextField(
              controller: _experienceController,
              label: 'Years of Experience',
              keyboardType: TextInputType.number,
              validator: (value) => value?.isEmpty ?? true
                  ? 'Please enter your experience'
                  : null,
            ),
            const SizedBox(height: 16),
            // Address Field
            _buildTextField(
              controller: _addressController,
              label: 'Address',
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Please enter your address' : null,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  setState(() => _currentStep = 2);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method for text fields
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
    void Function(String)? onChanged,
    bool readOnly = false, // Added default value for readOnly
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(labelText: label),
      validator: validator,
      onChanged: onChanged,
      readOnly: readOnly,
    );
  }

  // Save worker data to Firestore
  Future<void> saveWorkerData() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId != null) {
      final userRef =
          FirebaseFirestore.instance.collection('Users').doc(userId);

      try {
        // Save first name, last name, and other worker details
        await userRef.update({
          'firstName': _firstNameController.text,
          'lastName': _lastNameController.text,
          'phoneNumber': _phoneController.text,
          'email': _emailController.text,
          'experience': _experienceController.text,
          'address': _addressController.text,
          'services': _selectedWorkType,
          'hourly_rate': _hourlyRate,
          'role': 'worker',
        });

        Get.offAll(() => const WorkerHomePage());
      } catch (e) {
        print('Error saving worker data: $e');
      }
    }
  }

  // Step 2: Work Type Selection
  Widget _buildWorkTypeSelection() {
    final List<Map<String, dynamic>> workTypes = [
      {'icon': Icons.agriculture, 'name': 'Agricultural Worker'},
      {'icon': Icons.apartment, 'name': 'Apartment Maintenance'},
      {'icon': Icons.auto_awesome, 'name': 'Auto Mechanic'},
      {'icon': Icons.bike_scooter, 'name': 'Bike Mechanic'},
      {'icon': Icons.brush, 'name': 'Painter'},
      {'icon': Icons.build, 'name': 'Builder'},
      {'icon': Icons.carpenter, 'name': 'Carpenter'},
      {'icon': Icons.cleaning_services, 'name': 'Cleaning'},
      {'icon': Icons.construction, 'name': 'Construction Worker'},
      {'icon': Icons.directions_car, 'name': 'Driver'},
      {'icon': Icons.electrical_services, 'name': 'Electrician'},
      {'icon': Icons.handyman, 'name': 'Handyman'},
    ];

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Select Work Type',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
              itemCount: workTypes.length,
              itemBuilder: (context, index) {
                final workType = workTypes[index];
                return ListTile(
                  leading: Icon(workType['icon'] as IconData),
                  title: Text(workType['name'] as String),
                  trailing: Radio<String>(
                    value: workType['name'] as String,
                    groupValue: _selectedWorkType,
                    onChanged: (value) {
                      setState(() => _selectedWorkType = value);
                    },
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: _selectedWorkType != null
                ? () {
                    setState(() => _currentStep = 3);
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }

  // Step 3: Hourly Rate Selection
  Widget _buildHourlyRateSelection() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Enter Your Hourly Rate',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          _buildTextField(
            controller: TextEditingController(text: _hourlyRate),
            label: 'Hourly Rate',
            keyboardType: TextInputType.number,
            validator: (value) =>
                value?.isEmpty ?? true ? 'Please enter your hourly rate' : null,
            onChanged: (value) => _hourlyRate = value,
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              if (_hourlyRate != null) {
                saveWorkerData();
                setState(() => _currentStep = 4); // Go to success screen
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  // Welcome Screen
  Widget _buildWelcomeScreen() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Welcome to the Worker Registration!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Please fill in the form to become a worker and offer your services.',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              setState(() => _currentStep = 1); // Move to the first step
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text('Get Started'),
          ),
        ],
      ),
    );
  }

  // Success Screen
  Widget _buildSuccessScreen() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 100,
            ),
            const SizedBox(height: 16),
            const Text(
              'Registration Successful!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Get.offAll(() => const WorkerHomePage());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Go to Home Page'),
            ),
          ],
        ),
      ),
    );
  }
}
