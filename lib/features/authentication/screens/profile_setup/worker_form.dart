import 'package:flutter/material.dart';
import 'package:home_service_app/features/authentication/screens/woker_show_form.dart';

class WorkerForm extends StatefulWidget {
  const WorkerForm({super.key});

  @override
  State<WorkerForm> createState() => _WorkerRegistrationFlowState();
}

class _WorkerRegistrationFlowState extends State<WorkerForm> {
  int _currentStep = 0;
  final _formKey = GlobalKey<FormState>();

  // Form controllers
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _workTypeController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  String? _selectedWorkType;
  String? _selectedCountry;

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
          'Become a worker',
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
                      ? _buildCountrySelection()
                      : _buildSuccessScreen(),
    );
  }

  Widget _buildWelcomeScreen() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: const DecorationImage(
                image: NetworkImage('https://example.com/worker-image.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'BECOME A WORKER WITH US?',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const Text(
            'Join Our Workforce Today',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          _buildFeatureItem(
            icon: Icons.trending_up,
            title: 'Increased Job Opportunities',
            description:
                'Access to a wide range of job opportunities flexible working hours',
          ),
          const SizedBox(height: 16),
          _buildFeatureItem(
            icon: Icons.star,
            title: 'Enhanced Professional Reputation',
            description:
                'Build credibility through user reviews and experience points',
          ),
          const SizedBox(height: 16),
          _buildFeatureItem(
            icon: Icons.business_center,
            title: 'Convenient Business Management',
            description:
                'Enjoy a hassle-free payment process with secure and direct earnings deposited into your account',
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () => setState(() => _currentStep = 1),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Register Now'),
          ),
          TextButton(
            onPressed: () {},
            child: const Text(
              'Need Help?',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegistrationForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTextField(
              controller: _fullNameController,
              label: 'Full Name',
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Please enter your full name' : null,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _phoneController,
              label: 'Phone Number',
              keyboardType: TextInputType.phone,
              validator: (value) => value?.isEmpty ?? true
                  ? 'Please enter your phone number'
                  : null,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _emailController,
              label: 'Email Address',
              keyboardType: TextInputType.emailAddress,
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Please enter your email' : null,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _experienceController,
              label: 'Years of experience',
              keyboardType: TextInputType.number,
              validator: (value) => value?.isEmpty ?? true
                  ? 'Please enter your experience'
                  : null,
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
      {'icon': Icons.healing, 'name': 'Healthcare Assistant'},
      {'icon': Icons.home_repair_service, 'name': 'Home Repair Specialist'},
      {'icon': Icons.house, 'name': 'Housekeeper'},
      {'icon': Icons.kitchen, 'name': 'Kitchen Staff'},
      {'icon': Icons.landscape, 'name': 'Gardener'},
      {'icon': Icons.local_fire_department, 'name': 'Fire Safety Officer'},
      {'icon': Icons.local_gas_station, 'name': 'Gas Technician'},
      {'icon': Icons.local_hospital, 'name': 'Paramedic'},
      {'icon': Icons.local_shipping, 'name': 'Logistics Worker'},
      {'icon': Icons.lock, 'name': 'Locksmith'},
      {'icon': Icons.map, 'name': 'Surveyor'},
      {'icon': Icons.military_tech, 'name': 'Security Guard'},
      {'icon': Icons.plumbing, 'name': 'Plumber'},
      {'icon': Icons.precision_manufacturing, 'name': 'Machinist'},
      {'icon': Icons.ramen_dining, 'name': 'Catering Staff'},
      {'icon': Icons.roofing, 'name': 'Roofer'},
    ];

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Select work type',
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
                    // Redirect to the TargetPage when the button is pressed
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text('Ok'),
          ),
        ],
      ),
    );
  }

  Widget _buildCountrySelection() {
    final countries = ['Morocco', 'Africa', 'Europe', 'Asia', 'Usa'];

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Select Experience Country',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
              itemCount: countries.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(countries[index]),
                  trailing: Radio<String>(
                    value: countries[index],
                    groupValue: _selectedCountry,
                    onChanged: (value) {
                      setState(() => _selectedCountry = value);
                    },
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: _selectedCountry != null
                ? () => setState(() => _currentStep = 4)
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text('Ok'),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WorkerInfoPage(
          fullName: _fullNameController.text,
          phone: _phoneController.text,
          email: _emailController.text,
          experience: _experienceController.text,
          workType: _selectedWorkType ?? '',
          country: _selectedCountry ?? '',
        ),
      ),
    );
    return const SizedBox
        .shrink(); // Optional: Placeholder since this function won't return a UI anymore.
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.orange.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.orange),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                description,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.black),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}
