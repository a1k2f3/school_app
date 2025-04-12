import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> createUser(Map<String, dynamic> userData) async {
    try {
      await _firestore.collection('users').add(userData);
    } catch (e) {
      throw Exception('Error creating user: $e');
    }
  }
  Future<void> Userlogin(String email, String password, String role) async {
  try {
    // Query the Firestore collection for a user with the given email, password, and role
    final querySnapshot = await _firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .where('password', isEqualTo: password)
        .where('role', isEqualTo: role)
        .get();

    // Check if a user was found
    if (querySnapshot.docs.isEmpty) {
      throw Exception('No user found with the provided email, password, and role.');
    }

    // Retrieve the user data
    final userData = querySnapshot.docs.first.data();
    print('User logged in successfully: $userData');
  } catch (e) {
    throw Exception('Error logging in user: $e');
  }
}
  Future<List<Map<String, dynamic>>> readUsers() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('users').get();
      return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    } catch (e) {
      throw Exception('Error reading users: $e');
    }
  }
  Future<void> updateUser(String docId, Map<String, dynamic> updatedData) async {
    try {
      await _firestore.collection('users').doc(docId).update(updatedData);
    } catch (e) {
      throw Exception('Error updating user: $e');
    }
  }

  Future<void> deleteUser(String docId) async {
    try {
      await _firestore.collection('users').doc(docId).delete();
    } catch (e) {
      throw Exception('Error deleting user: $e');
    }
  }
Future<void> createclasses(Map<String, dynamic> productData) async {
    try {
      await _firestore.collection('classes').add(productData);
    } catch (e) {
      throw Exception('Error creating product: $e');
    }
  }

  Future<List<Map<String, dynamic>>> readclasses() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('classes').get();
      return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    } catch (e) {
      throw Exception('Error reading products: $e');
    }
  }

  Future<void> updateclasses(String docId, Map<String, dynamic> updatedData) async {
    try {
      await _firestore.collection('classes').doc(docId).update(updatedData);
    } catch (e) {
      throw Exception('Error updating product: $e');
    }
  }

  Future<void> deleteclasses(String docId) async {
    try {
      await _firestore.collection('classes').doc(docId).delete();
    } catch (e) {
      throw Exception('Error deleting product: $e');
    }
  }
  Future<void> createCourse(Map<String, dynamic> assignmentData) async {
    try {
      await _firestore.collection('courses').add(assignmentData);
    } catch (e) {
      throw Exception('Error creating assignment: $e');
    }
  }
  Future<List<Map<String, dynamic>>> readCourse() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('courses').get();
      return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    } catch (e) {
      throw Exception('Error reading assignments: $e');
    }
  }
  Future<void> updateCourse(String docId, Map<String, dynamic> updatedData) async {
    try {
      await _firestore.collection('courses').doc(docId).update(updatedData);
    } catch (e) {
      throw Exception('Error updating assignment: $e');
    }
  }
  Future<void> deleteCourse(String docId) async {
    try {
      await _firestore.collection('courses').doc(docId).delete();
    } catch (e) {
      throw Exception('Error deleting assignment: $e');
    }
  }
  Future<void> createAssignment(Map<String, dynamic> assignmentData) async {
    try {
      await _firestore.collection('assignments').add(assignmentData);
    } catch (e) {
      throw Exception('Error creating assignment: $e');
    }
  }
  Future<List<Map<String, dynamic>>> readAssignment() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('assignments').get();
      return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    } catch (e) {
      throw Exception('Error reading assignments: $e');
    }
  }
  Future<void> updateAssignment(String docId, Map<String, dynamic> updatedData) async {
    try {
      await _firestore.collection('assignments').doc(docId).update(updatedData);
    } catch (e) {
      throw Exception('Error updating assignment: $e');
    }
  }
  Future<void> deleteAssignment(String docId) async {
    try {
      await _firestore.collection('assignments').doc(docId).delete();
    } catch (e) {
      throw Exception('Error deleting assignment: $e');
    }
  }
   
}