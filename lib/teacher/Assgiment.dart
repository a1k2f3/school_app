import 'package:flutter/material.dart';

class AssignmentsPage extends StatelessWidget {
  final List<Map<String, String>> assignments = [
    {
      'title': 'Math Worksheet',
      'subject': 'Mathematics',
      'due': 'April 20, 2025',
      'status': 'Pending',
    },
    {
      'title': 'Science Project',
      'subject': 'Science',
      'due': 'April 22, 2025',
      'status': 'Submitted',
    },
    {
      'title': 'Essay on Environment',
      'subject': 'English',
      'due': 'April 25, 2025',
      'status': 'Pending',
    },
    {
      'title': 'History Presentation',
      'subject': 'Social Studies',
      'due': 'April 30, 2025',
      'status': 'Pending',
    },
  ];

  Color getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.orange;
      case 'Submitted':
        return Colors.green;
      default:
        return Colors.grey;
    }
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
            Text("Assignments", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: assignments.length,
                itemBuilder: (context, index) {
                  final assignment = assignments[index];
                  return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      title: Text(
                        assignment['title']!,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Text('Subject: ${assignment['subject']}'),
                          const SizedBox(height: 2),
                          Text('Due: ${assignment['due']}'),
                        ],
                      ),
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: getStatusColor(assignment['status']!).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          assignment['status']!,
                          style: TextStyle(
                            color: getStatusColor(assignment['status']!),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      onTap: () {
                        // You can navigate to detailed view or edit page here.
                      },
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
