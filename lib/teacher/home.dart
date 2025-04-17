import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final List<_DashboardCardData> dashboardItems = [
    _DashboardCardData(title: 'Students', icon: Icons.group, color: Colors.blue, count: 120),
    _DashboardCardData(title: 'Assignments', icon: Icons.assignment, color: Colors.deepPurple, count: 8),
    _DashboardCardData(title: 'Attendance', icon: Icons.check_circle, color: Colors.green, count: 97),
    _DashboardCardData(title: 'Messages', icon: Icons.message, color: Colors.orange, count: 15),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome, Teacher 👋",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            "Here's an overview of your activity",
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
          const SizedBox(height: 24),

          GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: dashboardItems.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 120,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemBuilder: (context, index) {
              final item = dashboardItems[index];
              return _DashboardCard(data: item);
            },
          ),
        ],
      ),
    );
  }
}

class _DashboardCardData {
  final String title;
  final IconData icon;
  final Color color;
  final int count;

  _DashboardCardData({
    required this.title,
    required this.icon,
    required this.color,
    required this.count,
  });
}

class _DashboardCard extends StatelessWidget {
  final _DashboardCardData data;

  const _DashboardCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: data.color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: data.color.withOpacity(0.3)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(data.icon, size: 26, color: data.color),
          const SizedBox(height: 12),
          Text(data.title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text('${data.count}', style: TextStyle(fontSize: 18, color: data.color, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
