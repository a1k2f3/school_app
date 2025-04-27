import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StudentAttendancePage extends StatelessWidget {
  // final String studentId; // The studentId to query from Firestore.
  final String studentId; // The userId to query from Firestore.
  
  const StudentAttendancePage({super.key,required this.studentId});

  // Fetch attendance records for a specific student
  Future<List<AttendanceRecord>> fetchAttendanceRecords() async {
    try {
      // Fetch attendance records from Firestore where studentId matches
      final querySnapshot = await FirebaseFirestore.instance
          .collection('attendance') // Your attendance collection
          .where('studentId', isEqualTo: studentId) // Filter by studentId
          .get();

      // Log the number of documents fetched
      print("Number of records fetched: ${querySnapshot.docs.length}");

      // Map query results to AttendanceRecord model
      return querySnapshot.docs.map((doc) {
        final data = doc.data();

        // Check if the date is stored as a string and parse it
        DateTime parsedDate;
        if (data['date'] is String) {
          // If date is a string, parse it manually.
          parsedDate = _parseDateString(data['date']);
        } else {
          // If date is already a Timestamp, convert it to DateTime.
          parsedDate = (data['date'] as Timestamp).toDate();
        }

        return AttendanceRecord(
          date: parsedDate,
          isPresent: data['present'],
        );
      }).toList();
    } catch (e) {
      // Handle any errors that occur during the Firestore query
      print("Error fetching attendance records: $e");
      return [];
    }
  }

  // Helper method to parse a date string into DateTime
  DateTime _parseDateString(String dateString) {
    // You can adjust the format depending on how the date is stored
    List<String> parts = dateString.split('-');
    int day = int.parse(parts[0]);
    int month = int.parse(parts[1]);
    int year = int.parse(parts[2]);

    return DateTime(year, month, day);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<AttendanceRecord>>(
      future: fetchAttendanceRecords(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error loading attendance.'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No attendance records found.'));
        } else {
          final attendanceRecords = snapshot.data!;
          int total = attendanceRecords.length;
          int presentCount = attendanceRecords.where((r) => r.isPresent).length;
          double percentage = total > 0 ? (presentCount / total) * 100 : 0.0;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Overall Attendance Summary Card
                Card(
                  color: Colors.blue[50],
                  child: ListTile(
                    title: const Text(
                      'Overall Attendance',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    subtitle: Text(
                      '${percentage.toStringAsFixed(1)}% Present',
                      style: const TextStyle(fontSize: 16),
                    ),
                    trailing: Icon(
                      Icons.check_circle,
                      color: percentage >= 75 ? Colors.green : Colors.red,
                      size: 32,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // List of Attendance Records
                Expanded(
                  child: ListView.builder(
                    itemCount: attendanceRecords.length,
                    itemBuilder: (context, index) {
                      AttendanceRecord record = attendanceRecords[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: ListTile(
                          leading: Icon(
                            record.isPresent ? Icons.check : Icons.close,
                            color: record.isPresent ? Colors.green : Colors.red,
                            size: 28,
                          ),
                          title: Text(
                            '${record.date.day}/${record.date.month}/${record.date.year}',
                            style: const TextStyle(fontSize: 16),
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
          );
        }
      },
    );
  }
}

// Model to represent an attendance record.
class AttendanceRecord {
  final DateTime date;
  final bool isPresent;

  AttendanceRecord({required this.date, required this.isPresent});
}
