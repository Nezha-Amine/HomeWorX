import 'package:flutter/material.dart';
import 'package:home_service_app/data/repositories/authentication/authentication_repository.dart';
import 'package:home_service_app/data/repositories/user/user_repository.dart';
import 'package:home_service_app/features/authentication/models/user_model.dart';
import 'package:home_service_app/features/authentication/screens/chat_page.dart';
import 'package:home_service_app/features/authentication/screens/login/login.dart';
import 'package:home_service_app/utils/constants/image_strings.dart';

class WorkerHomePage extends StatefulWidget {
  const WorkerHomePage({Key? key}) : super(key: key);

  @override
  State<WorkerHomePage> createState() => _WorkerHomePageState();
}

class _WorkerHomePageState extends State<WorkerHomePage> {
  int _selectedIndex = 0;

  Future<UserModel?> _fetchAuthenticatedWorkerData() async {
    try {
      return await UserRepository.instance.getAuthenticatedUserData();
    } catch (e) {
      print("Error fetching authenticated user data: $e");
      return null;
    }
  }

  void _onItemTapped(int index, BuildContext context) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ChatPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF1A386A),
        title: FutureBuilder<UserModel?>(
          future: _fetchAuthenticatedWorkerData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(color: Colors.white);
            } else if (snapshot.hasError) {
              return const Text(
                "Failed to load data",
                style: TextStyle(color: Colors.white),
              );
            } else if (snapshot.hasData && snapshot.data != null) {
              final worker = snapshot.data!;
              return Row(
                children: [
                  CircleAvatar(
                    backgroundImage: worker.profilePictureUrl != null
                        ? NetworkImage(worker.profilePictureUrl!)
                        : const AssetImage(HImages.user) as ImageProvider,
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hi! ${worker.firstName ?? ''} ${worker.lastName ?? ''}",
                        style:
                            const TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      Text(
                        worker.address ?? "Location not set",
                        style: const TextStyle(
                            fontSize: 12, color: Colors.white70),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Text("Off", style: TextStyle(color: Colors.white)),
                  Switch(
                    value: true,
                    onChanged: (value) {},
                    activeColor: Colors.green,
                  ),
                  const Icon(Icons.notifications, color: Colors.white),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.logout, color: Colors.white),
                    onPressed: () async {
                      try {
                        await AuthenticationRepository.instance.logout();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()),
                          (route) => false,
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed to logout: $e')),
                        );
                      }
                    },
                  ),
                ],
              );
            } else {
              return const Text(
                "No data available",
                style: TextStyle(color: Colors.white),
              );
            }
          },
        ),
      ),
      body: FutureBuilder<UserModel?>(
        future: _fetchAuthenticatedWorkerData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Failed to load data"));
          } else if (snapshot.hasData && snapshot.data != null) {
            final worker = snapshot.data!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Your Services",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  worker.services != null && worker.services!.isNotEmpty
                      ? Wrap(
                          spacing: 8.0,
                          runSpacing: 8.0,
                          children: worker.services!
                              .map((service) => _buildServiceChip(service))
                              .toList(),
                        )
                      : const Text("No services available."),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "New Requests",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "View all",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildRequestCard(),
                ],
              ),
            );
          } else {
            return const Center(child: Text("No data available"));
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => _onItemTapped(index, context),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Bookings'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: 'Calendar'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        selectedItemColor: const Color(0xFF153A77),
        unselectedItemColor: Colors.grey,
      ),
    );
  }

  Widget _buildServiceChip(String service) {
    return Chip(
      label: Text(
        service,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.blue.shade100,
    );
  }

  Widget _buildRequestCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: const DecorationImage(
                  image: AssetImage(HImages.acInstallation),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "AC Installation",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: const [
                Icon(Icons.calendar_today, size: 16),
                SizedBox(width: 8),
                Text("30 May, 2024 | 8:00 AM - 10:00 AM"),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              "Price: \$20/Hr",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage(HImages.user),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Adriel Effertz",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Casablanca, Morocco",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.red.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    "New Offer",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade300,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text("Decline",
                      style: TextStyle(color: Colors.black)),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text("Accept"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
