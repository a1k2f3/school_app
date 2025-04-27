import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:school_app/service/firestore_service.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
// import 'your_service_path/firestore_service.dart'; // <<--- ADD this line (update the path)

class CoursePage extends StatefulWidget {
  const CoursePage({super.key});
  @override
  _CoursePageState createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  double attendancePercentage = 85.0; // Example attendance value
  double courseProgress = 0.6; // 60% completion

  final List<String> videoIds = [
    "dQw4w9WgXcQ", // Replace with actual course video IDs
    "tgbNymZ7vqY",
  ];

  late YoutubePlayerController _youtubeController;
  late Future<List<Map<String, dynamic>>> _coursesFuture; // <<--- ADD this line

  @override
  void initState() {
    super.initState(); // <<--- uncomment this

    _coursesFuture = FirestoreService().readCourse(); // <<--- ADD this line

    _youtubeController = YoutubePlayerController(
      initialVideoId: videoIds[0],
      flags: YoutubePlayerFlags(autoPlay: true),
    );
  }

  @override
  void dispose() {
    _youtubeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Course Dashboard", style: TextStyle(fontSize: 20)),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAttendanceAndProgress(),
            SizedBox(height: 20),
            _buildDailyWork(),
            SizedBox(height: 20),
            _buildCourseOutline(), // <<< Here it is replaced
            SizedBox(height: 20),
            _buildVideoLessons(),
          ],
        ),
      ),
    );
  }

  Widget _buildAttendanceAndProgress() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text("Attendance", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            LinearProgressIndicator(
              value: attendancePercentage / 100,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
              minHeight: 8,
            ),
            SizedBox(height: 8),
            Text("${attendancePercentage.toStringAsFixed(1)}% Attended",
                style: TextStyle(fontSize: 16)),
            Divider(),
            Text("Course Progress", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            CircularPercentIndicator(
              radius: 80,
              lineWidth: 8,
              percent: courseProgress,
              center: Text("${(courseProgress * 100).toInt()}%"),
              progressColor: Colors.green,
              backgroundColor: Colors.grey[300]!,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyWork() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("📅 Daily Work", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            _buildTask("Watch Lecture Video", true),
            _buildTask("Complete Assignment 3", false),
            _buildTask("Attempt Quiz 5", false),
          ],
        ),
      ),
    );
  }

  Widget _buildTask(String taskName, bool isCompleted) {
    return ListTile(
      leading: Icon(
        isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
        color: isCompleted ? Colors.green : Colors.grey,
      ),
      title: Text(taskName, style: TextStyle(fontSize: 16)),
    );
  }

  // 🔵 Updated to fetch from Firestore
  Widget _buildCourseOutline() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _coursesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error loading course outline');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('No course outline available');
        } else {
          final courses = snapshot.data!;
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 4,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("📜 Course Outline", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  ...courses.map((course) {
                    return ExpansionTile(
                      title: Text(course['courseName'] ?? 'No Title'),
                      children: [
                        if (course['lessons'] != null)
                          ...List<Widget>.from((course['lessons'] as List<dynamic>).map((lesson) => ListTile(
                                title: Text(lesson),
                              )))
                      ],
                    );
                  }).toList(),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildVideoLessons() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("🎥 Video Lessons", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            YoutubePlayer(
              controller: _youtubeController,
              showVideoProgressIndicator: true,
            ),
          ],
        ),
      ),
    );
  }
}
