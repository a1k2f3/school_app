import 'package:flutter/material.dart';
import 'package:school_app/teacher/Attendance.dart';
import './home.dart';
import 'student.dart';
import 'Assgiment.dart';
import './Attendance.dart';
import 'profile.dart';

void main() => runApp(TeacherPanelApp());

class TeacherPanelApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Teacher Panel',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: TeacherPanel(),
    );
  }
}

class TeacherPanel extends StatefulWidget {
  @override
  _TeacherPanelState createState() => _TeacherPanelState();
}

class _TeacherPanelState extends State<TeacherPanel> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    StudentsPage(),
    AssignmentsPage(),
    AttendancePage(),
 ProfilePage  ( profileData: userData,
                userId: userId,), // Replace with actual user ID
  ];
  
  static get userData => null;
  
  static get userId => null;

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teacher Panel'),
        centerTitle: true,
      ),
      body: _pages[_selectedIndex],
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
