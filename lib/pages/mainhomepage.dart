import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:school_app/pages/course.dart';
import 'package:school_app/pages/help_support.dart';
import 'package:school_app/pages/profile.dart';
import 'package:school_app/pages/settings.dart';
import 'package:school_app/pages/upcomming_event.dart';

class Mainhomepage extends StatefulWidget {
  final Map<String, dynamic> studentData;
  final String userId;

  const Mainhomepage({
    required this.studentData,
    required this.userId,
    Key? key,
  }) : super(key: key);

  @override
  _MainhomepageState createState() => _MainhomepageState();
}

class _MainhomepageState extends State<Mainhomepage> {
  int _selectedIndex = 0;

  // Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to fetch courses from Firestore
  Future<List<Map<String, dynamic>>> fetchCourses() async {
    try {
      final snapshot = await _firestore.collection('courses').get();
      return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    } catch (e) {
      throw Exception('Error fetching courses: $e');
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      // Home tapped: Stay on Mainhomepage (no need to navigate again)
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Setting(studentData: widget.studentData, userId: widget.userId)),
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
    final studentData = widget.studentData;

    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Profile Section
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 4,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(
                            "https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png"),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        studentData['firstName'] ?? "No Name",
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      Text(
                        studentData['email'] ?? "No Email",
                        style: const TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.school, color: Colors.green),
                          SizedBox(width: 8),
                          Text("Academics: Good", style: TextStyle(fontSize: 18, color: Colors.black)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.attach_money, color: Colors.red),
                          SizedBox(width: 8),
                          Text("Pending Dues: 2000", style: TextStyle(fontSize: 18, color: Colors.black)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Last Date: 2025-03-07",
                        style: TextStyle(fontSize: 16, color: Colors.red),
                      ),
                      const Text(
                        "Days Left: 17",
                        style: TextStyle(fontSize: 16, color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Fetch and display the courses dynamically
              FutureBuilder<List<Map<String, dynamic>>>(
                future: fetchCourses(), // Fetch the courses
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No courses available.'));
                  }

                  final courses = snapshot.data!;

                  return Column(
                    children: courses.map((course) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          elevation: 4,
                          color: Colors.white,
                          child: ListTile(
                            leading: const Icon(Icons.book, color: Colors.purple),
                            title: Text(course['courseName'] ?? 'Unknown Course',
                                style: const TextStyle(fontSize: 18, color: Colors.black)),
                            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.blue),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => CoursePage()),
                              );
                            },
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),

              const Divider(),

              _buildNavigationCard(
                icon: Icons.event,
                title: "Upcoming Events",
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UpcomingEventApp()),
                ),
              ),
              const SizedBox(height: 10),
              _buildNavigationCard(
                icon: Icons.help,
                title: "Help & Support",
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HelpSupportApp()),
                ),
              ),
              const SizedBox(height: 10),
              _buildNavigationCard(
                icon: Icons.logout,
                title: "Logout",
                onTap: () {
                  // Implement logout logic
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildNavigationCard({required IconData icon, required String title, required VoidCallback onTap}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      color: Colors.white,
      child: ListTile(
        leading: Icon(icon, color: Colors.grey),
        title: Text(title, style: const TextStyle(fontSize: 18, color: Colors.black)),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.blue),
        onTap: onTap,
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
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
    );
  }
}
