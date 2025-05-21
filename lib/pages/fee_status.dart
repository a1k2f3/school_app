import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FeeStatusComponent extends StatefulWidget {
  final Map<String, dynamic> studentData;
  final String userId;

  const FeeStatusComponent({
    super.key,
    required this.studentData,
    required this.userId,
  });

  @override
  _FeeStatusComponentState createState() => _FeeStatusComponentState();
}

class _FeeStatusComponentState extends State<FeeStatusComponent> {
  Stream<QuerySnapshot> getFeeStream() {
    return FirebaseFirestore.instance
      .collection('users')
      .doc(widget.userId)
      .collection('fees')
      .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fee Status'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: getFeeStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No Fee Vouchers Found"));
          }

          final fees = snapshot.data!.docs;

          return ListView.builder(
            itemCount: fees.length,
            itemBuilder: (context, index) {
              final fee = fees[index];
              final amount = fee['amount'];
              final dueDate = fee['dueDate'];
              final status = fee['status'];

              return Card(
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                elevation: 2,
                child: ListTile(
                  leading: Icon(
                    status == "paid" ? Icons.check_circle : Icons.pending,
                    color: status == "paid" ? Colors.green : Colors.orange,
                  ),
                  title: Text("Amount: \$${amount.toString()}"),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Due Date: $dueDate"),
                    ],
                  ),
                  trailing: Text(
                    status.toUpperCase(),
                    style: TextStyle(
                      color: status == "paid" ? Colors.green : Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
