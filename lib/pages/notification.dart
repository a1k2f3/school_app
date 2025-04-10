import 'package:flutter/material.dart';

void main() {
  runApp(NotificationPreferenceApp());
}

class NotificationPreferenceApp extends StatelessWidget {
  const NotificationPreferenceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notification Preferences',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NotificationPreferencePage(),
    );
  }
}

class NotificationPreferencePage extends StatefulWidget {
  const NotificationPreferencePage({super.key});

  @override
  _NotificationPreferencePageState createState() =>
      _NotificationPreferencePageState();
}

class _NotificationPreferencePageState
    extends State<NotificationPreferencePage> {
  // Notification toggles.
  bool _pushNotifications = true;
  bool _emailNotifications = false;
  bool _smsNotifications = false;

  // Notification frequency options.
  String _notificationFrequency = 'Instant';
  final List<String> _frequencyOptions = ['Instant', 'Hourly', 'Daily'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification Preferences'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Text(
            'Manage your notification settings',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),

          // Push Notifications Toggle
          SwitchListTile(
            title: Text('Push Notifications'),
            subtitle: Text('Receive push notifications on your device.'),
            value: _pushNotifications,
            onChanged: (bool value) {
              setState(() {
                _pushNotifications = value;
              });
            },
          ),
          Divider(),

          // Email Notifications Toggle
          SwitchListTile(
            title: Text('Email Notifications'),
            subtitle: Text('Receive notifications via email.'),
            value: _emailNotifications,
            onChanged: (bool value) {
              setState(() {
                _emailNotifications = value;
              });
            },
          ),
          Divider(),

          // SMS Notifications Toggle
          SwitchListTile(
            title: Text('SMS Notifications'),
            subtitle: Text('Receive notifications via text messages.'),
            value: _smsNotifications,
            onChanged: (bool value) {
              setState(() {
                _smsNotifications = value;
              });
            },
          ),
          Divider(),

          SizedBox(height: 20),
          // Notification Frequency Dropdown.
          Text(
            'Notification Frequency',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          DropdownButton<String>(
            value: _notificationFrequency,
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  _notificationFrequency = newValue;
                });
              }
            },
            items: _frequencyOptions.map((String frequency) {
              return DropdownMenuItem<String>(
                value: frequency,
                child: Text(frequency),
              );
            }).toList(),
          ),

          SizedBox(height: 30),
          // Save Button
          ElevatedButton(
            onPressed: () {
              // Save preferences logic goes here.
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Notification preferences updated')),
              );
            },
            child: Text('Save Preferences'),
          ),
        ],
      ),
    );
  }
}
