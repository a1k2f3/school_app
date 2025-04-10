import 'package:flutter/material.dart';
import 'package:school_app/pages/Security.dart';
import 'package:school_app/pages/cusomize.dart';
import 'package:school_app/pages/help_support.dart';
import 'package:school_app/pages/notification.dart';
import 'package:school_app/pages/profile.dart';
import 'package:school_app/pages/mainhomepage.dart';
import 'package:school_app/pages/second_page.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final int _selectedIndex = 1; // Set default to settings

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Mainhomepage()));
    } else if (index == 2) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Profile()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9), // Light grey background
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Profile Card with gradient background
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
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
                          "https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png"),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "John Doe",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text(
                      "Roll No: 2024-ERP-001",
                      style: TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // Settings Options List
              _buildSettingOption(Icons.person, "Profile Setting", () {Navigator.push(context, MaterialPageRoute(builder: (context) =>  Profile()));}),
              _buildSettingOption(Icons.lock, "Account & Security", () { Navigator.push(context, MaterialPageRoute(builder: (context) =>  AccountSecurityApp()));}),
              _buildSettingOption(
                  Icons.notifications, "Notification Preferences", () { Navigator.push(context, MaterialPageRoute(builder: (context) =>  NotificationPreferenceApp()));}),
              _buildSettingOption(Icons.update, "Theme & Customization", () { Navigator.push(context, MaterialPageRoute(builder: (context) =>  SchoolApp()));}),
              _buildSettingOption(Icons.logout, "Logout & Account Management",
                  () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>   SecondPage()));
              }),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
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
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'Settings'),
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

  // Custom Method to Build Setting Options
  Widget _buildSettingOption(IconData icon, String title, VoidCallback onTap) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      color: Colors.white,
      child: ListTile(
        leading: Icon(icon, color: Colors.blueAccent),
        title: Text(title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.blueAccent),
        onTap: onTap,
      ),
    );
  }
}
