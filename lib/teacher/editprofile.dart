import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class EditProfilePage extends StatefulWidget {
  final String userId;
  final Map<String, dynamic> profileData;
  const EditProfilePage({Key? key, required this.userId, required this.profileData}) : super(key: key);
  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}
class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _qualificationController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _dobController;
  late TextEditingController _genderController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.profileData['firstName']);
    _qualificationController = TextEditingController(text: widget.profileData['qualifiction']);
    _emailController = TextEditingController(text: widget.profileData['email']);
    _phoneController = TextEditingController(text: widget.profileData['phone']);
    _dobController = TextEditingController(text: widget.profileData['dob']);
    _genderController = TextEditingController(text: widget.profileData['gender']);
  }

  Future<void> updateUser() async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(widget.userId).update({
        'firstName': _nameController.text,
        'qualifiction': _qualificationController.text,
        'email': _emailController.text,
        'phone': _phoneController.text,
        'dob': _dobController.text,
        'gender': _genderController.text,
      });

      Navigator.pop(context, true); // Return success
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error updating profile: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              buildTextField("Name", _nameController),
              buildTextField("Qualification", _qualificationController),
              buildTextField("Email", _emailController),
              buildTextField("Phone", _phoneController),
              buildTextField("Date of Birth", _dobController),
              buildTextField("Gender", _genderController),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: updateUser,
                child: const Text("Save Changes"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
