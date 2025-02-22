import 'package:flutter/material.dart';

void main() {
  runApp(Subject());
}
class Subject extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Courses',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UserCoursesPage(),
    );
  }
}

class UserCoursesPage extends StatelessWidget {
  // Sample course data.
  final List<Course> courses = [
    Course(
      title: 'Introduction to Programming',
      description: 'Learn the basics of programming using Dart and Flutter.',
      imageUrl: 'https://images.theconversation.com/files/45159/original/rptgtpxd-1396254731.jpg?ixlib=rb-4.1.0&q=45&auto=format&w=754&fit=clip',
    ),
    Course(
      title: 'Data Structures & Algorithms',
      description: 'Deep dive into data structures and algorithms in computer science.',
      imageUrl: 'hhttps://images.theconversation.com/files/45159/original/rptgtpxd-1396254731.jpg?ixlib=rb-4.1.0&q=45&auto=format&w=754&fit=clip',
    ),
    Course(
      title: 'Web Development',
      description: 'Master HTML, CSS, and JavaScript to build responsive websites.',
      imageUrl: 'https://images.theconversation.com/files/45159/original/rptgtpxd-1396254731.jpg?ixlib=rb-4.1.0&q=45&auto=format&w=754&fit=clip',
    ),
    Course(
      title: 'Mobile App Development',
      description: 'Learn to develop mobile apps for Android and iOS with Flutter.',
      imageUrl: 'https://images.theconversation.com/files/45159/original/rptgtpxd-1396254731.jpg?ixlib=rb-4.1.0&q=45&auto=format&w=754&fit=clip',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Courses'),
      ),
      body: ListView.builder(
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];
          return GestureDetector(
            onTap: () {
              // Display additional course details in a dialog.
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(course.title),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.network(course.imageUrl),
                        SizedBox(height: 8),
                        Text(course.description),
                      ],
                    ),
                    actions: [
                      TextButton(
                        child: Text('Close'),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  );
                },
              );
            },
            child: Card(
              margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              elevation: 3,
              child: ListTile(
                leading: Image.network(
                  course.imageUrl,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                title: Text(course.title),
                subtitle: Text(course.description),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
          );
        },
      ),
    );
  }
}

class Course {
  final String title;
  final String description;
  final String imageUrl;

  Course({
    required this.title,
    required this.description,
    required this.imageUrl,
  });
}
