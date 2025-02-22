import 'package:flutter/material.dart';

void main() {
  runApp(Attendence());
}

class Attendence extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My School App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: StudentAttendancePage(),
    );
  }
}

// Model to represent a single attendance record.
class AttendanceRecord {
  final DateTime date;
  final bool isPresent;

  AttendanceRecord({required this.date, required this.isPresent});
}

class StudentAttendancePage extends StatelessWidget {
  // Sample attendance records for the logged-in student.
  final List<AttendanceRecord> attendanceRecords = [
    AttendanceRecord(date: DateTime(2025, 2, 20), isPresent: true),
    AttendanceRecord(date: DateTime(2025, 2, 21), isPresent: true),
    AttendanceRecord(date: DateTime(2025, 2, 22), isPresent: false),
    AttendanceRecord(date: DateTime(2025, 2, 23), isPresent: true),
    AttendanceRecord(date: DateTime(2025, 2, 24), isPresent: true),
    // Add more records as needed.
  ];

  @override
  Widget build(BuildContext context) {
    // Calculate overall attendance percentage.
    int total = attendanceRecords.length;
    int presentCount =
        attendanceRecords.where((record) => record.isPresent).length;
    double percentage = total > 0 ? (presentCount / total) * 100 : 0.0;

    return Scaffold(
      appBar: AppBar(
        title: Text('My Attendance'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Overall Attendance Summary Card.
            Card(
              color: Colors.blue[50],
              child: ListTile(
                title: Text(
                  'Overall Attendance',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                subtitle: Text(
                  '${percentage.toStringAsFixed(1)}% Present',
                  style: TextStyle(fontSize: 16),
                ),
                trailing: Icon(
                  Icons.check_circle,
                  color: percentage >= 75 ? Colors.green : Colors.red,
                  size: 32,
                ),
              ),
            ),
            SizedBox(height: 20),
            // List of Daily Attendance Records.
            Expanded(
              child: ListView.builder(
                itemCount: attendanceRecords.length,
                itemBuilder: (context, index) {
                  AttendanceRecord record = attendanceRecords[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      leading: Icon(
                        record.isPresent ? Icons.check : Icons.close,
                        color: record.isPresent ? Colors.green : Colors.red,
                        size: 28,
                      ),
                      title: Text(
                        '${record.date.day}/${record.date.month}/${record.date.year}',
                        style: TextStyle(fontSize: 16),
                      ),
                      subtitle: Text(
                        record.isPresent ? 'Present' : 'Absent',
                        style: TextStyle(
                          fontSize: 14,
                          color: record.isPresent ? Colors.green : Colors.red,
                        ),
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
