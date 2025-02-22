import 'package:flutter/material.dart';

class DiaryViewComponent extends StatelessWidget {
  // Sample diary entries list. Replace these with your actual data.
  final List<DiaryEntry> diaryEntries = [
    DiaryEntry(
      title: 'Morning Reflections',
      content: 'Today I woke up feeling inspired and ready to tackle the day.',
      date: DateTime(2025, 2, 20, 8, 30),
    ),
    DiaryEntry(
      title: 'Afternoon Musings',
      content: 'A quiet walk in the park helped clear my mind and refocus.',
      date: DateTime(2025, 2, 20, 15, 45),
    ),
    DiaryEntry(
      title: 'Evening Thoughts',
      content: 'Winding down with some meditation and gratitude journaling.',
      date: DateTime(2025, 2, 20, 21, 10),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Diary'),
      ),
      body: diaryEntries.isEmpty
          ? Center(child: Text('No diary entries available.'))
          : ListView.builder(
              itemCount: diaryEntries.length,
              itemBuilder: (context, index) {
                final entry = diaryEntries[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  elevation: 2,
                  child: ListTile(
                    title: Text(entry.title),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(entry.content),
                        SizedBox(height: 4.0),
                        Text(
                          '${entry.date.toLocal()}'.split('.')[0],
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

// Model class for a diary entry.
class DiaryEntry {
  final String title;
  final String content;
  final DateTime date;

  DiaryEntry({
    required this.title,
    required this.content,
    required this.date,
  });
}
