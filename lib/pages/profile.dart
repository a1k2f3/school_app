import 'package:flutter/material.dart';
import 'package:school_app/pages/attendence.dart';
import 'package:school_app/pages/dairy.dart';
import 'package:school_app/pages/fee_status.dart';
import 'package:school_app/pages/result.dart';
import 'package:school_app/pages/second_page.dart';
import 'package:school_app/pages/settings.dart';
import 'package:school_app/pages/subject.dart';
import 'package:school_app/pages/timetable.dart';
class Profile extends StatelessWidget {
  const Profile({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
  icon: Icon(Icons.arrow_back, color: Colors.black),
  onPressed: () {
    Navigator.pop(context);
  },
),
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
                  buildNavigationListTile(context,Icons.calendar_today, Colors.black,"Attendance",Attendence()),
                  buildNavigationListTile(context,Icons.school,Colors.black,"Grades & Results",StudentResultPage()),
                  buildNavigationListTile( context,Icons.access_time,Colors.black, "Timetable",Timetable()),
                  buildNavigationListTile(context,Icons.book,Colors.black, "Courses & Subjects",Subject()),
                  buildNavigationListTile(context,Icons.payment,Colors.black, "Fee Status",FeeStatusComponent()),
                  buildNavigationListTile(context,Icons.assignment,Colors.black, "Dairy",DiaryViewComponent() ),        
                  Divider(),
                 buildNavigationListTile(context,Icons.settings,Colors.black,
                 "Settings",Settings() ),
                  buildNavigationListTile(context,Icons.logout, Colors.red, "Log out",SecondPage() ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  // Helper function for creating ListTiles
  ListTile buildNavigationListTile(
    BuildContext context,
    IconData icon,
    Color iconColor,
    String title,
    Widget destinationPage,
  ) {
  return ListTile(
    leading: Icon(icon, color: iconColor),
    title: Text(title, style: TextStyle(fontSize: 16)),
    trailing: Icon(Icons.arrow_forward_ios, size: 16),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => destinationPage),
      );
    },
  );
}

}
