import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Added

class AssignmentsPage extends StatefulWidget {
  @override
  _AssignmentsPageState createState() => _AssignmentsPageState();
}

class _AssignmentsPageState extends State<AssignmentsPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance; // Added

  List<Map<String, dynamic>> assignments = [];
  bool isLoading = true;
  String? currentUserId; // Added

  @override
  void initState() {
    super.initState();
    currentUserId = _auth.currentUser?.uid; // Get current user ID
    fetchAssignments();
  }

  Future<void> fetchAssignments() async {
    try {
      final snapshot = await _firestore.collection('assignments').get();
      final data = snapshot.docs.map((doc) {
        return {
          'id': doc.id,
          ...doc.data(),
        };
      }).toList();

      setState(() {
        assignments = data;
        isLoading = false;
      });
    } catch (e) {
      print('Error reading assignments: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> updateAssignmentStatus(String assignmentId, String newStatus) async {
    try {
      await _firestore.collection('assignments').doc(assignmentId).update({
        'status': newStatus,
      });
      fetchAssignments(); // Refresh the list after update
    } catch (e) {
      print('Error updating status: $e');
    }
  }

  void showStatusUpdateSheet(BuildContext context, String assignmentId) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Update Status', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              ListTile(
                title: Text('Pending'),
                onTap: () {
                  updateAssignmentStatus(assignmentId, 'Pending');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Submitted'),
                onTap: () {
                  updateAssignmentStatus(assignmentId, 'Submitted');
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

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
      appBar: AppBar(
        title: Text('Assignments'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Your Assignments", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : assignments.isEmpty
                      ? Center(child: Text("No assignments found."))
                      : ListView.builder(
                          itemCount: assignments.length,
                          itemBuilder: (context, index) {
                            final assignment = assignments[index];
                            final isOwner = assignment['userId'] == currentUserId;

                            return Card(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              elevation: 2,
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              child: ListTile(
                                contentPadding: const EdgeInsets.all(16),
                                title: Text(
                                  assignment['title'] ?? 'No Title',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 4),
                                    Text('Subject: ${assignment['subject'] ?? 'N/A'}'),
                                    const SizedBox(height: 2),
                                    Text('Due: ${assignment['deadline'] ?? 'N/A'}'),
                                  ],
                                ),
                                trailing: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: getStatusColor(assignment['status'] ?? '').withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    assignment['status'] ?? 'Unknown',
                                    style: TextStyle(
                                      color: getStatusColor(assignment['status'] ?? ''),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                onTap: isOwner
                                    ? () {
                                        showStatusUpdateSheet(context, assignment['id']);
                                      }
                                    : () {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text('You can only update your own assignments!')),
                                        );
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
