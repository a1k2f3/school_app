import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Icon(Icons.arrow_back, color: Colors.black,),
        title: Text(
          "Student Profile",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          Icon(Icons.settings, color: Colors.black),
          SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            // Profile Image and Info
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                        "https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png"),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "John Doe",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Roll No: 2024-ERP-001",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text("Edit Profile"),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // ERP Portal Options
            Expanded(
              child: ListView(
                children: [
                  buildListTile(Icons.calendar_today, "Attendance", context),
                  buildListTile(Icons.school, "Grades & Results", context),
                  buildListTile(Icons.access_time, "Timetable", context),
                  buildListTile(Icons.book, "Courses & Subjects", context),
                  buildListTile(Icons.payment, "Fee Status", context),
                  buildListTile(Icons.assignment, "Dairy", context),        
                  Divider(),
                  buildListTile(Icons.settings,  "Settings", context),
                  buildListTile(Icons.logout, "Log out", context, iconColor: Colors.red),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function for creating ListTiles
  Widget buildListTile(IconData icon, String title, BuildContext context, {Color iconColor = Colors.black}) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(title, style: TextStyle(fontSize: 16)),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        // Implement navigation logic here
      },
    );
  }
}
