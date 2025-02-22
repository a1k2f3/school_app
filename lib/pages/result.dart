import 'package:flutter/material.dart';

void main() {
  runApp(StudentResultApp());
}

class StudentResultApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grades & Results',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StudentResultPage(),
    );
  }
}

// Model for a grade record
class GradeRecord {
  final String subject;
  final String grade;
  final double score;

  GradeRecord({
    required this.subject,
    required this.grade,
    required this.score,
  });
}

class StudentResultPage extends StatelessWidget {
  // Sample grade records for the logged-in student.
  final List<GradeRecord> gradeRecords = [
    GradeRecord(subject: 'Mathematics', grade: 'A', score: 95),
    GradeRecord(subject: 'Science', grade: 'B+', score: 88),
    GradeRecord(subject: 'English', grade: 'A-', score: 92),
    GradeRecord(subject: 'History', grade: 'B', score: 85),
    GradeRecord(subject: 'Computer Science', grade: 'A', score: 97),
  ];

  // Function to calculate overall average score.
  double calculateAverageScore() {
    double totalScore =
        gradeRecords.fold(0, (sum, record) => sum + record.score);
    return totalScore / gradeRecords.length;
  }

  // Determine overall grade based on average score.
  String calculateOverallGrade(double avgScore) {
    if (avgScore >= 90) {
      return 'A';
    } else if (avgScore >= 80) {
      return 'B';
    } else if (avgScore >= 70) {
      return 'C';
    } else if (avgScore >= 60) {
      return 'D';
    } else {
      return 'F';
    }
  }

  @override
  Widget build(BuildContext context) {
    double averageScore = calculateAverageScore();
    String overallGrade = calculateOverallGrade(averageScore);

    return Scaffold(
      appBar: AppBar(
        title: Text('Grades & Results'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Overall Results Summary
            Card(
              color: Colors.blue[50],
              child: ListTile(
                leading: Icon(Icons.school, size: 40, color: Colors.blue),
                title: Text(
                  'Overall Result',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                subtitle: Text(
                  'Average Score: ${averageScore.toStringAsFixed(1)}%\nOverall Grade: $overallGrade',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 20),
            // List of Subject Grades
            Expanded(
              child: ListView.builder(
                itemCount: gradeRecords.length,
                itemBuilder: (context, index) {
                  final record = gradeRecords[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    elevation: 2,
                    child: ListTile(
                      leading: Icon(Icons.book, color: Colors.blue),
                      title: Text(
                        record.subject,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(
                        'Score: ${record.score}%    Grade: ${record.grade}',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
