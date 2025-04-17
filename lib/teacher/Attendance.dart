import 'package:flutter/material.dart';

class AttendancePage extends StatefulWidget {
  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  final List<Map<String, dynamic>> students = [
    {'name': 'Ali Raza', 'id': 'STU001', 'present': false},
    {'name': 'Ayesha Khan', 'id': 'STU002', 'present': false},
    {'name': 'Hassan Tariq', 'id': 'STU003', 'present': false},
    {'name': 'Zara Ahmed', 'id': 'STU004', 'present': false},
    {'name': 'Fatima Malik', 'id': 'STU005', 'present': false},
  ];

  String getTodayDate() {
    final now = DateTime.now();
    return "${now.day}-${now.month}-${now.year}";
  }

  void toggleAttendance(int index) {
    setState(() {
      students[index]['present'] = !students[index]['present'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Attendance", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text("Date: ${getTodayDate()}", style: TextStyle(color: Colors.grey[600])),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: students.length,
                itemBuilder: (context, index) {
                  final student = students[index];
                  return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      leading: CircleAvatar(
                        backgroundColor: Colors.indigo,
                        child: Text(
                          student['name'][0],
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(student['name'], style: TextStyle(fontWeight: FontWeight.w600)),
                      subtitle: Text(student['id']),
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
