import 'package:flutter/material.dart';

void main() {
  runApp(Timetable());
}

class Timetable extends StatelessWidget {
  const Timetable({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'School Timetable',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TimetablePage(),
    );
  }
}

class TimetablePage extends StatefulWidget {
  const TimetablePage({super.key});

  @override
  _TimetablePageState createState() => _TimetablePageState();
}

class _TimetablePageState extends State<TimetablePage> {
  // Dummy timetable data with days as keys and a list of schedule maps.
  final Map<String, List<Map<String, String>>> timetable = {
    'Monday': [
      {'time': '08:00 - 09:00', 'subject': 'Mathematics'},
      {'time': '09:15 - 10:15', 'subject': 'English'},
      {'time': '10:30 - 11:30', 'subject': 'Science'},
    ],
    'Tuesday': [
      {'time': '08:00 - 09:00', 'subject': 'History'},
      {'time': '09:15 - 10:15', 'subject': 'Geography'},
      {'time': '10:30 - 11:30', 'subject': 'Art'},
    ],
    'Wednesday': [
      {'time': '08:00 - 09:00', 'subject': 'Physics'},
      {'time': '09:15 - 10:15', 'subject': 'Chemistry'},
      {'time': '10:30 - 11:30', 'subject': 'Biology'},
    ],
    'Thursday': [
      {'time': '08:00 - 09:00', 'subject': 'Computer Science'},
      {'time': '09:15 - 10:15', 'subject': 'Physical Education'},
      {'time': '10:30 - 11:30', 'subject': 'Music'},
    ],
    'Friday': [
      {'time': '08:00 - 09:00', 'subject': 'Literature'},
      {'time': '09:15 - 10:15', 'subject': 'Economics'},
      {'time': '10:30 - 11:30', 'subject': 'Drama'},
    ],
  };

  String selectedDay = 'Monday';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('School Timetable'),
      ),
      body: Column(
        children: [
          // Horizontal day selector
          Container(
            height: 60,
            padding: EdgeInsets.symmetric(vertical: 8),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: timetable.keys.map((day) {
                bool isSelected = day == selectedDay;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDay = day;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blue : Colors.grey[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        day,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          // Timetable list for the selected day
          Expanded(
            child: ListView.builder(
              itemCount: timetable[selectedDay]?.length ?? 0,
              itemBuilder: (context, index) {
                var schedule = timetable[selectedDay]![index];
                return Card(
                  margin: EdgeInsets.all(8),
                  elevation: 3,
                  child: ListTile(
                    title: Text(schedule['subject']!),
                    subtitle: Text(schedule['time']!),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      // Show details when tapping on a schedule
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(schedule['subject']!),
                            content: Text(
                                'Class: ${schedule['subject']!}\nTime: ${schedule['time']!}\n\nMore details can be added here.'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('Close'),
                              )
                            ],
                          );
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
