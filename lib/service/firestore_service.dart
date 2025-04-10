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
      await _firestore.collection('course').add(assignmentData);
    } catch (e) {
      throw Exception('Error creating assignment: $e');
    }
  }
  Future<List<Map<String, dynamic>>> readCourse() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('course').get();
      return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    } catch (e) {
      throw Exception('Error reading assignments: $e');
    }
  }
  Future<void> updateCourse(String docId, Map<String, dynamic> updatedData) async {
    try {
      await _firestore.collection('course').doc(docId).update(updatedData);
    } catch (e) {
      throw Exception('Error updating assignment: $e');
    }
  }
  Future<void> deleteCourse(String docId) async {
    try {
      await _firestore.collection('course').doc(docId).delete();
    } catch (e) {
      throw Exception('Error deleting assignment: $e');
    }
  }
}