import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:school_app/service/firestore_service.dart';
import 'package:school_app/teacher/pane.dart'; // For kIsWeb
// import 'package:file_picker/file_picker.dart';
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
              child: const Text("Course manegment"),
            ),
              const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  CreateTeacherPage(),
                  ),
                );
              },
              child: const Text("Teacher Manegment"),
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
              child: const Text("Assign classes"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  CreateStudentPage(),
                  ),
                );
              },
              child: const Text("Manege Student"),
            ),
            const SizedBox(height: 10),        
             const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Assignment(),
                  ),
                );
              },
              child: const Text("Asginment Management"),
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
class Assignment extends StatefulWidget {
  const Assignment({super.key});

  @override
  State<Assignment> createState() => _AssignmentState();
}

class _AssignmentState extends State<Assignment> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _deadlineController = TextEditingController();
  final TextEditingController _classNameController = TextEditingController();

  Future<void> _addAssignment() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Pick admin file
        FilePickerResult? result = await FilePicker.platform.pickFiles();
        
        
        await _firestore.collection('assignments').add({
            'title': _titleController.text,
            'description': _descriptionController.text,
            'deadline': _deadlineController.text,
            'className': _classNameController.text,
            'userFileUrl': null,
          });
          _clearForm();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Assignment added successfully')),
          );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error adding assignment: $e')),
        );
        print(e)  ;
      }
    }
  }
  Future<void> _uploadUserFile(String docId) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        final file = result.files.single;
        final filePath = file.path!;
        final fileName = file.name;

        // Upload file to Firebase Storage
        final ref = _storage.ref().child('user_tasks/$fileName');
        await ref.putFile(File(filePath));
        final fileUrl = await ref.getDownloadURL();

        // Update Firestore with user file URL
        await _firestore.collection('assignments').doc(docId).update({
          'userFileUrl': fileUrl,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('File uploaded successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No file selected')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading file: $e')),
      );
    }
  }

  Future<void> _deleteAssignment(String docId) async {
    try {
      await _firestore.collection('assignments').doc(docId).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Assignment deleted successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting assignment: $e')),
      );
    }
  }
  void _clearForm() {
    _titleController.clear();
    _descriptionController.clear();
    _deadlineController.clear();
    _classNameController.clear();
  }

  Future<void> _pickDeadline() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      _deadlineController.text = pickedDate.toIso8601String().split('T').first;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Assignments"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(labelText: 'Title'),
                    validator: (value) =>
                        value!.isEmpty ? 'Title is required' : null,
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(labelText: 'Description'),
                    validator: (value) =>
                        value!.isEmpty ? 'Description is required' : null,
                  ),
                  TextFormField(
                    controller: _deadlineController,
                    readOnly: true,
                    decoration: const InputDecoration(labelText: 'Deadline'),
                    onTap: _pickDeadline,
                    validator: (value) =>
                        value!.isEmpty ? 'Deadline is required' : null,
                  ),
                  TextFormField(
                    controller: _classNameController,
                    decoration: const InputDecoration(labelText: 'Class Name'),
                    validator: (value) =>
                        value!.isEmpty ? 'Class Name is required' : null,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _addAssignment,
                    child: const Text('Add Assignment'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('assignments').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No assignments found'));
                }
                final assignments = snapshot.data!.docs;
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: assignments.length,
                  itemBuilder: (context, index) {
                    final assignmentData =
                        assignments[index].data() as Map<String, dynamic>;
                    final docId = assignments[index].id;
                    return ListTile(
                      title: Text(assignmentData['title']),
                      subtitle: Text(
                          'Class: ${assignmentData['className']}\nDeadline: ${assignmentData['deadline']}\nDescription: ${assignmentData['description']}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.upload_file,
                                color: Colors.blue),
                            onPressed: () => _uploadUserFile(docId),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteAssignment(docId),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CreateStudentPage extends StatelessWidget {
  final FirestoreService _firestoreService = FirestoreService();

  CreateStudentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Management"),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _firestoreService.readUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No student records found.'));
          }

          final students = snapshot.data!;

          return ListView.builder(
            itemCount: students.length,
            itemBuilder: (context, index) {
              final student = students[index];
              final docId = student['id'] ?? ''; // Safeguard against null

              return ListTile(
                title: Text(student['firstName'] ?? 'No Name'),
                subtitle: Text(
                  'Email: ${student['email'] ?? 'No Email'}\n'
                  'Sex: ${student['gender'] ?? 'Unknown'}',
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () => _showEditDialog(context, docId, student),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteStudent(context, docId),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showEditDialog(
      BuildContext context, String docId, Map<String, dynamic> users) {
    final TextEditingController nameController =
        TextEditingController(text: users['firstName'] ?? '');
    final TextEditingController emailController =
        TextEditingController(text: users['email'] ?? '');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Student'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                final updatedData = {
                  'firstName': nameController.text,
                  'email': emailController.text,
                };
                try {
                  await _firestoreService.updateUser(docId, updatedData);
                  Navigator.pop(context);
                } catch (e) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Update failed: $e')),
                  );
                  print(e);
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _deleteStudent(BuildContext context, String docId) async {
    try {
      await _firestoreService.deleteUser(docId);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Student deleted successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting student: $e')),
      );
    }
  }
}
class CreateTeacherPage extends StatelessWidget {
  final FirestoreService _firestoreService = FirestoreService();

  CreateTeacherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Teacher Management"),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _firestoreService.readAllUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No teacher records found.'));
          }

          final teachers = snapshot.data!
              .where((user) => user['role'] == 'Teacher')
              .toList();

          if (teachers.isEmpty) {
            return const Center(child: Text('No teacher records found.'));
          }

          return ListView.builder(
            itemCount: teachers.length,
            itemBuilder: (context, index) {
              final teacher = teachers[index];
              final docId = teacher['id'] ?? '';

              return ListTile(
                title: Text(teacher['firstName'] ?? 'No Name'),
                subtitle: Text(
                  'Email: ${teacher['email'] ?? 'No Email'}\n'
                  'Gender: ${teacher['gender'] ?? 'Unknown'}',
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () =>
                          _showEditDialog(context, docId, teacher),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteTeacher(context, docId),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showEditDialog(
      BuildContext context, String docId, Map<String, dynamic> teacher) {
    final TextEditingController nameController =
        TextEditingController(text: teacher['firstName'] ?? '');
    final TextEditingController emailController =
        TextEditingController(text: teacher['email'] ?? '');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Teacher'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                final updatedData = {
                  'firstName': nameController.text,
                  'email': emailController.text,
                };
                try {
                  await _firestoreService.updateUser(docId, updatedData);
                  Navigator.pop(context);
                } catch (e) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Update failed: $e')),
                  );
                  print(e);
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _deleteTeacher(BuildContext context, String docId) async {
    try {
      await _firestoreService.deleteUser(docId);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Teacher deleted successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting teacher: $e')),
      );
    }
  }
}
