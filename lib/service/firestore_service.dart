import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ------------------ USERS ------------------

  Future<void> createUser(Map<String, dynamic> userData) async {
    try {
      await _firestore.collection('users').add(userData);
    } catch (e) {
      throw Exception('Error creating user: $e');
    }
  }

  Future<void> userLogin(String email, String password, String role) async {
    try {
      final querySnapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .where('password', isEqualTo: password)
          .where('role', isEqualTo: role)
          .get();

      if (querySnapshot.docs.isEmpty) {
        throw Exception('No user found with the provided email, password, and role.');
      }

      final userData = querySnapshot.docs.first.data();
      print('User logged in successfully: $userData');
    } catch (e) {
      throw Exception('Error logging in user: $e');
    }
  }

  Future<List<Map<String, dynamic>>> readUsers() async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .where('role', isEqualTo: 'Student')
          .get();

      return snapshot.docs.map(_mapDocWithId).toList();
    } catch (e) {
      throw Exception('Error reading users: $e');
    }
  }

  Future<List<Map<String, dynamic>>> readAllUsers() async {
    try {
      final snapshot = await _firestore.collection('users').get();
      return snapshot.docs.map(_mapDocWithId).toList();
    } catch (e) {
      throw Exception('Error reading all users: $e');
    }
  }

  Future<Map<String, dynamic>?> readUserById(String userId) async {
    try {
      final doc = await _firestore.collection('users').doc(userId).get();
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return data;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Error reading user: $e');
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

  // ------------------ CLASSES ------------------

  Future<void> createClasses(Map<String, dynamic> classData) async {
    try {
      await _firestore.collection('classes').add(classData);
    } catch (e) {
      throw Exception('Error creating class: $e');
    }
  }

  Future<List<Map<String, dynamic>>> readClasses() async {
    try {
      final snapshot = await _firestore.collection('classes').get();
      return snapshot.docs.map(_mapDocWithId).toList();
    } catch (e) {
      throw Exception('Error reading classes: $e');
    }
  }

  Future<void> updateClasses(String docId, Map<String, dynamic> updatedData) async {
    try {
      await _firestore.collection('classes').doc(docId).update(updatedData);
    } catch (e) {
      throw Exception('Error updating class: $e');
    }
  }

  Future<void> deleteClasses(String docId) async {
    try {
      await _firestore.collection('classes').doc(docId).delete();
    } catch (e) {
      throw Exception('Error deleting class: $e');
    }
  }

  // ------------------ COURSES ------------------

  Future<void> createCourse(Map<String, dynamic> courseData) async {
    try {
      await _firestore.collection('courses').add(courseData);
    } catch (e) {
      throw Exception('Error creating course: $e');
    }
  }

  Future<List<Map<String, dynamic>>> readCourse() async {
    try {
      final snapshot = await _firestore.collection('courses').get();
      return snapshot.docs.map(_mapDocWithId).toList();
    } catch (e) {
      throw Exception('Error reading courses: $e');
    }
  }

  Future<void> updateCourse(String docId, Map<String, dynamic> updatedData) async {
    try {
      await _firestore.collection('courses').doc(docId).update(updatedData);
    } catch (e) {
      throw Exception('Error updating course: $e');
    }
  }

  Future<void> deleteCourse(String docId) async {
    try {
      await _firestore.collection('courses').doc(docId).delete();
    } catch (e) {
      throw Exception('Error deleting course: $e');
    }
  }

  // ------------------ ASSIGNMENTS ------------------

  Future<void> createAssignment(Map<String, dynamic> assignmentData) async {
    try {
      await _firestore.collection('assignments').add(assignmentData);
    } catch (e) {
      throw Exception('Error creating assignment: $e');
    }
  }

  Future<List<Map<String, dynamic>>> readAssignment() async {
    try {
      final snapshot = await _firestore.collection('assignments').get();
      return snapshot.docs.map(_mapDocWithId).toList();
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

  // ------------------ HELPER ------------------

  Map<String, dynamic> _mapDocWithId(QueryDocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    data['id'] = doc.id;
    return data;
  }

}
