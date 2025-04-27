import 'package:flutter/material.dart';
import 'package:school_app/pages/Security.dart';
import 'package:school_app/pages/cusomize.dart';
import 'package:school_app/pages/notification.dart';
import 'package:school_app/pages/profile.dart';
import 'package:school_app/pages/mainhomepage.dart';
import 'package:school_app/pages/second_page.dart';

class Setting extends StatefulWidget {
  final dynamic studentData;
  final String userId;

  const Setting({super.key, required this.studentData, required this.userId});

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Setting> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Mainhomepage(
            studentData: widget.studentData,
            userId: widget.userId,
          ),
        ),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Profile(
            studentData: widget.studentData,
            userId: widget.userId,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final student = widget.studentData;
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Profile Card
              Container(
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(
                        "https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png",
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      student?['firstName'] ?? "No Name",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      student?['email'] ?? "No Email",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Settings Options
              _buildSettingOption(
                Icons.person,
                "Profile Setting",
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Profile(
                        studentData: widget.studentData,
                        userId: widget.userId,
                      ),
                    ),
                  );
                },
              ),
              _buildSettingOption(
                Icons.lock,
                "Account & Security",
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AccountSecurityApp()),
                  );
                },
              ),
              _buildSettingOption(
                Icons.notifications,
                "Notification Preferences",
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NotificationPreferenceApp()),
                  );
                },
              ),
              _buildSettingOption(
                Icons.update,
                "Theme & Customization",
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SchoolApp()),
                  );
                },
              ),
              _buildSettingOption(
                Icons.logout,
                "Logout & Account Management",
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SecondPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.amber[800],
            onTap: _onItemTapped,
            backgroundColor: Colors.transparent,
            elevation: 0,
            unselectedItemColor: Colors.white70,
          ),
        ),
      ),
    );
  }

  Widget _buildSettingOption(IconData icon, String title, VoidCallback onTap) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      color: Colors.white,
      child: ListTile(
        leading: Icon(icon, color: Colors.blueAccent),
        title: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.blueAccent),
        onTap: onTap,
      ),
    );
  }
}
