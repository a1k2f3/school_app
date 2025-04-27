import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:school_app/pages/attendence.dart';
import 'package:school_app/pages/course.dart';
import 'package:school_app/pages/dairy.dart';
import 'package:school_app/pages/fee_status.dart';
import 'package:school_app/pages/result.dart';
import 'package:school_app/pages/second_page.dart';
import 'package:school_app/pages/settings.dart';
import 'package:school_app/pages/subject.dart';
import 'package:school_app/pages/timetable.dart';

class Profile extends StatefulWidget {
  final Map<String, dynamic> studentData;
  final String userId;

  const Profile({super.key, required this.studentData, required this.userId});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.studentData['firstName'] ?? '');
    _emailController = TextEditingController(text: widget.studentData['email'] ?? '');
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

 void _saveProfile() async {
  setState(() {
    widget.studentData['firstName'] = _nameController.text;
    widget.studentData['email'] = _emailController.text;
    _isEditing = false;
  });

  // 🔥 Yeh sirf Firestore update operation add kiya hai niche
  try {
    await FirebaseFirestore.instance.collection('users').doc(widget.userId).update({
      'firstName': _nameController.text,
      'email': _emailController.text,
      'password': _passwordController.text,
    });
  } catch (e) {
    print('Error updating profile in Firestore: $e');
  }
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
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Student Profile",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      "https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png",
                    ),
                  ),
                  const SizedBox(height: 10),
                  _isEditing
                      ? TextField(
                          controller: _nameController,
                          decoration: const InputDecoration(labelText: 'Name'),
                        )
                      : Text(
                          widget.studentData['firstName'] ?? 'Unknown Name',
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                  _isEditing
                      ? TextField(
                          controller: _emailController,
                          decoration: const InputDecoration(labelText: 'Email'),
                        )
                      : Text(
                          widget.studentData['email'] ?? 'No Email Provided',
                          style: const TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                  if (_isEditing)
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(labelText: 'Password'),
                    ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (_isEditing) {
                        _saveProfile();
                      } else {
                        setState(() {
                          _isEditing = true;
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(_isEditing ? "Update" : "Edit Profile"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  buildNavigationListTile(context, Icons.calendar_today, Colors.black, "Attendance",StudentAttendancePage(studentId: widget.userId,  )),
                  buildNavigationListTile(context, Icons.school, Colors.black, "Grades & Results", StudentResultPage()),
                  buildNavigationListTile(context, Icons.access_time, Colors.black, "Timetable", Timetable()),
                  buildNavigationListTile(context, Icons.book, Colors.black, "Courses & Subjects", CoursePage()),
                  buildNavigationListTile(context, Icons.payment, Colors.black, "Fee Status", FeeStatusComponent()),
                  buildNavigationListTile(context, Icons.assignment, Colors.black, "Dairy", AssignmentsPage()),
                  const Divider(),
                  buildNavigationListTile(context, Icons.settings, Colors.black, "Settings", Setting(studentData: widget.studentData, userId: widget.userId)),
                  buildNavigationListTile(context, Icons.logout, Colors.red, "Log out", SecondPage()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListTile buildNavigationListTile(
    BuildContext context,
    IconData icon,
    Color iconColor,
    String title,
    Widget destinationPage,
  ) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(title, style: const TextStyle(fontSize: 16)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destinationPage),
        );
      },
    );
  }
}
