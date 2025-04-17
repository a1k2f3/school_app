import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({super.key});
  @override
  _CoursePageState createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  double attendancePercentage = 85.0; // Example attendance value
  double courseProgress = 0.6; // 60% completion

  // Sample Video Lessons (YouTube)
  final List<String> videoIds = [
    "dQw4w9WgXcQ", // Replace with actual course video IDs
    "tgbNymZ7vqY",
  ];

  late YoutubePlayerController _youtubeController;

  @override
  void initState() {
    // super.initState();
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
            // Attendance & Progress Overview
            _buildAttendanceAndProgress(),

            SizedBox(height: 20),

            // Daily Work
            _buildDailyWork(),

            SizedBox(height: 20),

            // Course Outline
            _buildCourseOutline(),

            SizedBox(height: 20),

            // Video Lessons
            _buildVideoLessons(),
          ],
        ),
      ),
    );
  }

  // Attendance and Progress Card
  Widget _buildAttendanceAndProgress() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Attendance Progress
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

            // Course Progress Tracker
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

  // Daily Work Summary
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

  // Task List with Checkboxes
  Widget _buildTask(String taskName, bool isCompleted) {
    return ListTile(
      leading: Icon(
        isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
        color: isCompleted ? Colors.green : Colors.grey,
      ),
      title: Text(taskName, style: TextStyle(fontSize: 16)),
    );
  }

  // Course Outline
  Widget _buildCourseOutline() {
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
            ExpansionTile(
              title: Text("Module 1: Introduction"),
              children: [ListTile(title: Text("Lesson 1: Basics of Flutter")), ListTile(title: Text("Lesson 2: UI Components"))],
            ),
            ExpansionTile(
              title: Text("Module 2: Advanced Topics"),
              children: [ListTile(title: Text("Lesson 3: State Management")), ListTile(title: Text("Lesson 4: API Integration"))],
            ),
          ],
        ),
      ),
    );
  }

  // Video Lessons
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
