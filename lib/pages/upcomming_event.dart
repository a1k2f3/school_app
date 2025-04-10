import 'package:flutter/material.dart';

void main() {
  runApp(UpcomingEventApp());
}

class UpcomingEventApp extends StatelessWidget {
  const UpcomingEventApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Upcoming Events',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UpcomingEventPage(),
    );
  }
}

class UpcomingEventPage extends StatelessWidget {
  // Sample list of upcoming events.
  final List<Event> events = [
    Event(
      title: "Science Fair 2025",
      date: "March 10, 2025",
      location: "School Auditorium",
      description:
          "Join us for an exciting day of science exhibits and experiments.",
    ),
    Event(
      title: "Annual Sports Day",
      date: "April 5, 2025",
      location: "Sports Ground",
      description:
          "Participate in various sporting events and enjoy a day of fun activities.",
    ),
    Event(
      title: "Art & Craft Exhibition",
      date: "May 20, 2025",
      location: "Art Gallery",
      description:
          "Explore creative artworks and craft projects by our talented students.",
    ),
  ];

  UpcomingEventPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upcoming Events"),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: events.length,
        itemBuilder: (context, index) {
          return EventCard(event: events[index]);
        },
      ),
    );
  }
}

// Model class representing an event.
class Event {
  final String title;
  final String date;
  final String location;
  final String description;

  Event({
    required this.title,
    required this.date,
    required this.location,
    required this.description,
  });
}

// Widget that builds an individual event card.
class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and Date row.
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  event.title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  event.date,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            // Location information.
            Row(
              children: [
                Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
                SizedBox(width: 4),
                Text(
                  event.location,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            // Event description.
            Text(
              event.description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 12),
            // "Learn More" button.
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    // TODO: Navigate to event details or registration.
                  },
                  child: Text("Learn More"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
