import 'package:flutter/material.dart';

class AdminPanelPage extends StatelessWidget {
  const AdminPanelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Panel"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Welcome to the Admin Panel",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ManageCoursesPage(),
                  ),
                );
              },
              child: const Text("Manage Courses (CRUD)"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AssignCoursesPage(),
                  ),
                );
              },
              child: const Text("Assign Courses to Class and Teacher"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateTimetablePage(),
                  ),
                );
              },
              child: const Text("Create Timetable"),
            ),
          ],
        ),
      ),
    );
  }
}

class ManageCoursesPage extends StatelessWidget {
  const ManageCoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Courses"),
      ),
      body: const Center(
        child: Text(
          "CRUD Operations for Courses",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
class AssignCoursesPage extends StatelessWidget {
  const AssignCoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Assign Courses"),
      ),
      body: const Center(
        child: Text(
          "Assign Courses to Classes and Teachers",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
class CreateTimetablePage extends StatelessWidget {
  const CreateTimetablePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Timetable"),
      ),
      body: const Center(
        child: Text(
          "Timetable Creation Page",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}