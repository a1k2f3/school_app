import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './home.dart';
import 'student.dart';
import 'Assgiment.dart';
import './Attendance.dart';
import './editprofile.dart';

class ProfilePage extends StatefulWidget {
  final String userId;

  const ProfilePage({
    Key? key,
    required this.userId, required profileData,
  }) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic>? profileData;
  int _selectedIndex = 4; // Set default to Profile tab

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  Future<void> fetchUser() async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userId)
          .get();
      if (doc.exists) {
        setState(() {
          profileData = doc.data() as Map<String, dynamic>;
        });
      } else {
        print("User not found");
      }
    } catch (e) {
      print('Error fetching user: $e');
    }
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  Widget _buildProfileContent() {
    if (profileData == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 30),
          CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(profileData!['image'] ?? ''),
          ),
          const SizedBox(height: 16),
          Text(profileData!['firstName'] ?? '',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(profileData!['qualifiction'] ?? '',
              style: TextStyle(color: Colors.grey[700], fontSize: 16)),
          const SizedBox(height: 20),
          const Divider(),
          _buildInfoTile("Email", profileData!['email'] ?? ''),
          _buildInfoTile("Phone", profileData!['phone'] ?? ''),
          _buildInfoTile("Gender", profileData!['gender'] ?? ''),
          _buildInfoTile("Date of Birth", profileData!['dob'] ?? ''),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () async {
  final result = await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => EditProfilePage(
        userId: widget.userId,
        profileData: profileData!,
      ),
    ),
  );

  // Reload user if updated
  if (result == true) {
    fetchUser();
  }
},

          icon: const Icon(Icons.edit),
            label: const Text("Edit Profile"),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 6, 214, 33),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTile(String label, String value) {
    return ListTile(
      title: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(value),
      leading: Icon(_getIcon(label), color: Colors.indigo),
    );
  }

  IconData _getIcon(String label) {
    switch (label) {
      case "Email":
        return Icons.email;
      case "Phone":
        return Icons.phone;
      case "Gender":
        return Icons.person;
      case "Date of Birth":
        return Icons.cake;
      case "Address":
        return Icons.location_on;
      default:
        return Icons.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
     HomePage(),
      StudentsPage(),
       AssignmentsPage(),
      AttendancePage(),
      _buildProfileContent(),
    ];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.indigo,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Students'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Assignments'),
          BottomNavigationBarItem(icon: Icon(Icons.check_circle), label: 'Attendance'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
