import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AttendancePage extends StatefulWidget {
  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Map<String, dynamic>> students = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchStudents().then((_) => calculateStudentAttendancePercentage());
  }

  Future<void> fetchStudents() async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .where('role', isEqualTo: 'Student')
          .get();

      final data = snapshot.docs.map((doc) {
        final user = doc.data();
        return {
          'id': doc.id,
          'name': user['firstName'],
          'present': false,
          'attendancePercentage': 0.0,
        };
      }).toList();

      setState(() {
        students = data;
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching students: $e");
    }
  }

  Future<void> calculateStudentAttendancePercentage() async {
    for (int i = 0; i < students.length; i++) {
      final studentId = students[i]['id'];

      try {
        final querySnapshot = await _firestore
            .collection('attendance')
            .where('studentId', isEqualTo: studentId)
            .get();

        final total = querySnapshot.docs.length;
        final present = querySnapshot.docs
            .where((doc) => doc['present'] == true)
            .length;

        double percentage = total > 0 ? (present / total) * 100 : 0;

        setState(() {
          students[i]['attendancePercentage'] = percentage;
        });
      } catch (e) {
        print("Error fetching attendance for student $studentId: $e");
      }
    }
  }

  String getTodayDate() {
    final now = DateTime.now();
    return "${now.day}-${now.month}-${now.year}";
  }
  void toggleAttendance(int index) {
    setState(() {
      students[index]['present'] = !students[index]['present'];
    });
  }

  Future<void> submitAttendance() async {
    final today = getTodayDate();

    for (var student in students) {
      final attendanceData = {
        'studentId': student['id'],
        'name': student['name'],
        'present': student['present'],
        'date': today,
      };

      try {
        await _firestore.collection('attendance').add(attendanceData);
      } catch (e) {
        print("Error saving attendance: $e");
      }
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content:
              Text("Attendance submitted for ${students.length} students.")),
    );

    // Recalculate percentages after submitting
    calculateStudentAttendancePercentage();
  }

  double calculateTodayPercentage() {
    if (students.isEmpty) return 0;
    int presentCount = students.where((s) => s['present'] == true).length;
    return (presentCount / students.length) * 100;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Attendance'),
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: submitAttendance,
          )
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Date: ${getTodayDate()}",
                      style: TextStyle(color: Colors.grey[600])),
                  const SizedBox(height: 8),
                  Text(
                    "Today's Present: ${calculateTodayPercentage().toStringAsFixed(1)}%",
                    style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: students.length,
                      itemBuilder: (context, index) {
                        final student = students[index];
                        return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          elevation: 2,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            leading: CircleAvatar(
                              backgroundColor: Colors.indigo,
                              child: Text(
                                student['name'][0],
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            title: Text(student['name'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600)),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("ID: ${student['id']}"),
                                Text(
                                    "Overall: ${student['attendancePercentage'].toStringAsFixed(1)}%"),
                              ],
                            ),
                            trailing: Switch(
                              value: student['present'],
                              onChanged: (_) => toggleAttendance(index),
                              activeColor: Colors.green,
                            ),
                          ),
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
