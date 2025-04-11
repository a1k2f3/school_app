import 'package:cloud_firestore/cloud_firestore.dart';
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
                    builder: (context) => const ManageCourses(),
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
              child: const Text("Assign Courses to Classes"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AssignClasses(),
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

class ManageCourses extends StatefulWidget {
  const ManageCourses({super.key});

  @override
  State<ManageCourses> createState() => _ManageCoursesState();
}

class _ManageCoursesState extends State<ManageCourses> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _courseNameController = TextEditingController();
  final TextEditingController _courseCodeController = TextEditingController();
  final TextEditingController _classAssignedController = TextEditingController();
  final TextEditingController _teacherAssignedController = TextEditingController();

  Future<void> _addCourse() async {
    if (_courseNameController.text.isNotEmpty &&
        _courseCodeController.text.isNotEmpty &&
        _classAssignedController.text.isNotEmpty &&
        _teacherAssignedController.text.isNotEmpty) {
      try {
        await _firestore.collection('courses').add({
          'courseName': _courseNameController.text,
          'courseCode': _courseCodeController.text,
          'classAssigned': _classAssignedController.text,
          'teacherAssigned': _teacherAssignedController.text,
        });
        _courseNameController.clear();
        _courseCodeController.clear();
        _classAssignedController.clear();
        _teacherAssignedController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Course added successfully')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error adding course: $e')),
        );
      }
    }
  }

  Future<void> _deleteCourse(String docId) async {
    try {
      await _firestore.collection('courses').doc(docId).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Course deleted successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting course: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Courses"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _courseNameController,
              decoration: const InputDecoration(labelText: 'Course Name'),
            ),
            TextField(
              controller: _courseCodeController,
              decoration: const InputDecoration(labelText: 'Course Code'),
            ),
            TextField(
              controller: _classAssignedController,
              decoration: const InputDecoration(labelText: 'Class Assigned'),
            ),
            TextField(
              controller: _teacherAssignedController,
              decoration: const InputDecoration(labelText: 'Teacher Assigned'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addCourse,
              child: const Text('Add Course'),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('courses').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('No courses found'));
                  }
                  final courses = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: courses.length,
                    itemBuilder: (context, index) {
                      final courseData = courses[index].data() as Map<String, dynamic>;
                      final docId = courses[index].id;
                      return ListTile(
                        title: Text('${courseData['courseName']} (${courseData['courseCode']})'),
                        subtitle: Text(
                          'Class: ${courseData['classAssigned']}\nTeacher: ${courseData['teacherAssigned']}',
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteCourse(docId),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
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
class AssignClasses extends StatefulWidget {
  const AssignClasses({super.key});

  @override
  State<AssignClasses> createState() => _AssignClassesState();
}

class _AssignClassesState extends State<AssignClasses> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _classNameController = TextEditingController();
  final TextEditingController _sectionController = TextEditingController();

  Future<void> _addClass() async {
    if (_classNameController.text.isNotEmpty && _sectionController.text.isNotEmpty) {
      try {
        await _firestore.collection('classes').add({
          'className': _classNameController.text,
          'section': _sectionController.text,
        });
        _classNameController.clear();
        _sectionController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Class added successfully')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error adding class: $e')),
        );
      }
    }
  }

  Future<void> _deleteClass(String docId) async {
    try {
      await _firestore.collection('classes').doc(docId).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Class deleted successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting class: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AssClasses"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _classNameController,
              decoration: const InputDecoration(labelText: 'Class Name'),
            ),
            TextField(
              controller: _sectionController,
              decoration: const InputDecoration(labelText: 'Section'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addClass,
              child: const Text('Add Class'),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('classes').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('No classes found'));
                  }
                  final classes = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: classes.length,
                    itemBuilder: (context, index) {
                      final classData = classes[index].data() as Map<String, dynamic>;
                      final docId = classes[index].id;
                      return ListTile(
                        title: Text('${classData['className']} - ${classData['section']}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteClass(docId),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
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