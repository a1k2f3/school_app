import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(const AdminMessagesPage());
}

class AdminMessagesPage extends StatefulWidget {
  const AdminMessagesPage({super.key});

  @override
  _AdminMessagesPageState createState() => _AdminMessagesPageState();
}

class _AdminMessagesPageState extends State<AdminMessagesPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to read messages from Firestore
  Future<List<Map<String, dynamic>>> readMessage() async {
    try {
      final snapshot = await _firestore.collection('messages').get();
      return snapshot.docs.map((doc) => _mapDocWithId(doc)).toList();
    } catch (e) {
      throw Exception('Error reading messages: $e');
    }
  }

  // Map the Firestore document to a Map with additional fields (like ID)
  Map<String, dynamic> _mapDocWithId(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    data['id'] = doc.id; // Add document ID to the data
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin - User Messages'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: readMessage(), // Call the function to get the messages
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No messages available.'));
          }

          final messages = snapshot.data!;

          return ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final message = messages[index];

              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  contentPadding: EdgeInsets.all(16),
                  title: Text(message['name'] ?? 'No name'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Email: ${message['email'] ?? 'No email'}'),
                      SizedBox(height: 8),
                      Text('Message: ${message['message'] ?? 'No message'}'),
                      SizedBox(height: 8),
                      Text('Sent at: ${message['timestamp']?.toDate()}'),
                    ],
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
