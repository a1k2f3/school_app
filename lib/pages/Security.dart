import 'package:flutter/material.dart';

void main() {
  runApp(AccountSecurityApp());
}

class AccountSecurityApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Account & Security',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AccountSecurityPage(),
    );
  }
}

class AccountSecurityPage extends StatefulWidget {
  @override
  _AccountSecurityPageState createState() => _AccountSecurityPageState();
}

class _AccountSecurityPageState extends State<AccountSecurityPage> {
  final _accountFormKey = GlobalKey<FormState>();
  String _username = '';
  String _email = '';
  final _securityFormKey = GlobalKey<FormState>();
  String _currentPassword = '';
  String _newPassword = '';
  String _confirmPassword = '';
  bool _twoFactorEnabled = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account & Security'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Account Details Section
            Text(
              'Account Details',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 10),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _accountFormKey,
                  child: Column(
                    children: [
                      TextFormField(
                        initialValue: _username,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          border: OutlineInputBorder(),
                        ),
                        onSaved: (value) {
                          _username = value ?? '';
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a username';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        initialValue: _email,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                        onSaved: (value) {
                          _email = value ?? '';
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an email';
                          }
                          if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          if (_accountFormKey.currentState!.validate()) {
                            _accountFormKey.currentState!.save();
                            // Process the updated account details here
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Account details updated')),
                            );
                          }
                        },
                        child: Text('Update Account'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Security Settings Section
            Text(
              'Security Settings',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 10),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Password Change Form
                    Form(
                      key: _securityFormKey,
                      child: Column(
                        children: [
                          TextFormField(
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Current Password',
                              border: OutlineInputBorder(),
                            ),
                            onSaved: (value) {
                              _currentPassword = value ?? '';
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your current password';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'New Password',
                              border: OutlineInputBorder(),
                            ),
                            onSaved: (value) {
                              _newPassword = value ?? '';
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a new password';
                              }
                              if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Confirm New Password',
                              border: OutlineInputBorder(),
                            ),
                            onSaved: (value) {
                              _confirmPassword = value ?? '';
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please confirm your new password';
                              }
                              if (value != _newPassword) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              if (_securityFormKey.currentState!.validate()) {
                                _securityFormKey.currentState!.save();
                                // Process the password update here
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Password updated')),
                                );
                              }
                            },
                            child: Text('Change Password'),
                          ),
                        ],
                      ),
                    ),
                    Divider(height: 30),
                    // Two-Factor Authentication Toggle
                    SwitchListTile(
                      title: Text('Enable Two-Factor Authentication'),
                      value: _twoFactorEnabled,
                      onChanged: (bool value) {
                        setState(() {
                          _twoFactorEnabled = value;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(_twoFactorEnabled
                                ? 'Two-Factor Authentication enabled'
                                : 'Two-Factor Authentication disabled'),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}