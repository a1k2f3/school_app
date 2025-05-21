import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FeeManagementPage extends StatefulWidget {
  @override
  _FeeManagementPageState createState() => _FeeManagementPageState();
}

class _FeeManagementPageState extends State<FeeManagementPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _feeAmountController = TextEditingController();
  final TextEditingController _dueDateController = TextEditingController();

  Future<void> createFee(String userId, Map<String, dynamic> feeData) async {
    try {
      await _firestore.collection('users').doc(userId).collection('fees').add(feeData);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Fee Voucher Created for Student")));
    } catch (e) {
      throw Exception('Error creating fee: $e');
    }
  }

  Future<void> updateFeeStatus(String userId, String feeId, String newStatus) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('fees')
          .doc(feeId)
          .update({'status': newStatus});
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Fee status updated")));
    } catch (e) {
      throw Exception('Error updating fee status: $e');
    }
  }

  Future<List<Map<String, dynamic>>> readAllStudents() async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .where('role', isEqualTo: 'Student')
          .get();

      return snapshot.docs.map((doc) {
        return {
          'id': doc.id,
          ...doc.data() as Map<String, dynamic>,
        };
      }).toList();
    } catch (e) {
      throw Exception('Error reading students: $e');
    }
  }

  Stream<QuerySnapshot> readFees(String userId) {
    return _firestore.collection('users').doc(userId).collection('fees').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Fee Management")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _feeAmountController,
              decoration: InputDecoration(labelText: "Fee Amount"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _dueDateController,
              decoration: InputDecoration(labelText: "Due Date"),
              keyboardType: TextInputType.datetime,
            ),
            SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: readAllStudents(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text("No students found"));
                  }

                  final students = snapshot.data!;
                  return ListView.builder(
                    itemCount: students.length,
                    itemBuilder: (context, index) {
                      final student = students[index];
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: ExpansionTile(
                          title: Text(student['firstName'] ?? "No Name"),
                          subtitle: Text(student['email'] ?? "No Email"),
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                if (_feeAmountController.text.isNotEmpty && _dueDateController.text.isNotEmpty) {
                                  final feeData = {
                                    'amount': _feeAmountController.text,
                                    'dueDate': _dueDateController.text,
                                    'status': 'unpaid', // New field
                                  };
                                  await createFee(student['id'], feeData);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Please fill all fields")),
                                  );
                                }
                              },
                              child: Text("Create Fee"),
                            ),
                            SizedBox(height: 10),
                            StreamBuilder<QuerySnapshot>(
                              stream: readFees(student['id']),
                              builder: (context, feeSnapshot) {
                                if (feeSnapshot.connectionState == ConnectionState.waiting) {
                                  return Center(child: CircularProgressIndicator());
                                }
                                if (feeSnapshot.hasError) {
                                  return Text("Error: ${feeSnapshot.error}");
                                }
                                if (!feeSnapshot.hasData || feeSnapshot.data!.docs.isEmpty) {
                                  return Text("No Fee Vouchers");
                                }
                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: feeSnapshot.data!.docs.length,
                                  itemBuilder: (context, feeIndex) {
                                    final fee = feeSnapshot.data!.docs[feeIndex];
                                    return ListTile(
                                      title: Text("Amount: ${fee['amount']}"),
                                      subtitle: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Due: ${fee['dueDate']}"),
                                          Row(
                                            children: [
                                              Text("Status: "),
                                              DropdownButton<String>(
                                                value: fee['status'],
                                                items: ['unpaid', 'paid', 'late'] // You can add more statuses
                                                    .map((status) => DropdownMenuItem(
                                                          value: status,
                                                          child: Text(status),
                                                        ))
                                                    .toList(),
                                                onChanged: (newStatus) async {
                                                  if (newStatus != null) {
                                                    await updateFeeStatus(student['id'], fee.id, newStatus);
                                                  }
                                                },
                                              ),
                                            ],
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
