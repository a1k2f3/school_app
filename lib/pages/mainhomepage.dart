import 'package:flutter/material.dart';
import 'package:school_app/pages/course.dart';
import 'package:school_app/pages/help_support.dart';
import 'package:school_app/pages/profile.dart';
import 'package:school_app/pages/settings.dart';
import 'package:school_app/pages/upcomming_event.dart';

class Mainhomepage extends StatefulWidget {
  final Map<String, dynamic> studentData;
  final String userId;

  const Mainhomepage({
    required this.studentData,
    required this.userId,
    Key? key,
  }) : super(key: key);
  @override
  _LengthConverterState createState() => _LengthConverterState();
}

class _LengthConverterState extends State<Mainhomepage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
      
        get userData => null;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if(index == 0){
      Navigator.push(context, MaterialPageRoute(builder: (context) => Mainhomepage( studentData: userData, userId:userData,)));
    } else if(index == 2){
      Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
    }
    else if(index == 1){
      Navigator.push(context, MaterialPageRoute(builder: (context) => Settings()));
    }
  }

  @override
  Widget build(BuildContext context) {
    widget.studentData['FirstName'] ;  // or whatever your key is
widget.studentData['email'];
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),  // Light grey background
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Profile Section
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 4,
                color: Colors.white, // White background for the card
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(
                            "https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png"),
                      ),
                      SizedBox(height: 10),
                      Text(
                        widget.studentData['firstName']?? "No Name" ,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      Text(
                        widget.studentData['email'] ?? "No Email",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.school, color: Colors.green),
                          SizedBox(width: 8),
                          Text("Academics: Good", style: TextStyle(fontSize: 18, color: Colors.black)),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.attach_money, color: Colors.red),
                          SizedBox(width: 8),
                          Text("Pending Dues: 2000", style: TextStyle(fontSize: 18, color: Colors.black)),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Last Date: 2025-03-07",
                        style: TextStyle(fontSize: 16, color: Colors.red),
                      ),
                      Text(
                        "Days Left: 17",
                        style: TextStyle(fontSize: 16, color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Dashboard Sections
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 4,
                color: Colors.white,
                child: ListTile(
                  leading: Icon(Icons.book, color: Colors.purple),
                  title: Text("General Science", style: TextStyle(fontSize: 18, color: Colors.black)),
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.blue),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CoursePage()));
   
                    // Implement your navigation logic
                  },
                ),
              ),
              SizedBox(height: 10),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 4,
                color: Colors.white,
                child: ListTile(
                  leading: Icon(Icons.book, color: Colors.purple),
                  title: Text("Social Studies", style: TextStyle(fontSize: 18, color: Colors.black)),
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.blue),
                  onTap: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context) => CoursePage()));
   
                    // Implement your navigation logic
                  },
                ),
              ),
              SizedBox(height: 10),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 4,
                color: Colors.white,
                child: ListTile(
                  leading: Icon(Icons.book, color: Colors.purple),
                  title: Text("Islamiat", style: TextStyle(fontSize: 18, color: Colors.black)),
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.blue),
                  onTap: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context) => CoursePage()));
   
                    // Implement your navigation logic
                  },
                ),
              ),
              // Additional Cards for subjects...
              SizedBox(height: 10),
               Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 4,
                color: Colors.white,
                child: ListTile(
                  leading: Icon(Icons.book, color: Colors.purple),
                  title: Text("Computer", style: TextStyle(fontSize: 18, color: Colors.black)),
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.blue),
                  onTap: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context) => CoursePage()));
   
                    // Implement your navigation logic
                  },
                ),
              ),
              Divider(),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 4,
                color: Colors.white,
                child: ListTile(
                  leading: Icon(Icons.event, color: Colors.grey),
                  title: Text("Upcomig Evants", style: TextStyle(fontSize: 18, color: Colors.black)),
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.blue),
                  onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => UpcomingEventApp()));
   
                  },
                ),
              ),
              SizedBox(height: 10),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 4,
                color: Colors.white,
                child: ListTile(
                  leading: Icon(Icons.help, color: Colors.blue),
                  title: Text("Help & Support", style: TextStyle(fontSize: 18, color: Colors.black)),
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.blue),
                  onTap: () {
                    // Implement your navigation logic
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  HelpSupportApp()));
                  },
                ),
              ),
              SizedBox(height: 10),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 4,
                color: Colors.white,
                child: ListTile(
                  leading: Icon(Icons.logout, color: Colors.red),
                  title: Text("Logout", style: TextStyle(fontSize: 18, color: Colors.black)),
                  trailing: Icon(Icons.event, color: Colors.blue),
                  onTap: () {
                    // Implement your logout logic
                  },
                ),
              ),
            ],
          ),
        ),
      ),
        bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'Settings'),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.amber[800],
            onTap: _onItemTapped,
            backgroundColor: Colors.transparent,
            elevation: 0,
            unselectedItemColor: Colors.white70,
          ),
        ))
    );
  }
}
