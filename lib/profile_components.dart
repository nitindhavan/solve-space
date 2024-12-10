import 'package:flutter/material.dart';

class ProfileDashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E1E2E),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Header
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFF2C2C3E),
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(20)),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage:
                        NetworkImage('https://via.placeholder.com/150'),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'John Doe',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Flutter Developer | Community Builder',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Statistics Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Your Stats',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStatCard('Problems\nSolved', '120', Colors.purple),
                  _buildStatCard('', '2.5K', Colors.blue),
                  _buildStatCard('Following', '180', Colors.orange),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Achievements Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Achievements',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _buildAchievementBadge('Top Contributor', Colors.green),
                  _buildAchievementBadge('100+ Posts', Colors.amber),
                  _buildAchievementBadge('Community Leader', Colors.red),
                  _buildAchievementBadge('5K Followers', Colors.purple),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _buildAchievementBadge('Top Contributor', Colors.green),
                  _buildAchievementBadge('100+ Posts', Colors.amber),
                  _buildAchievementBadge('Community Leader', Colors.red),
                  _buildAchievementBadge('5K Followers', Colors.purple),
                ],
              ),
            ),

            SizedBox(
              height: 20,
            ),
            // Recent Activities Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomBarGraph(
                problemStats: {
                  'Javascript': 20,
                  'Java': 15,
                  'Evergreen': 50,
                  'CSharp': 10,
                  'Titan': 5,
                  'Others': 5,

                },
              ),
            ),
            ActivityStreakComponent(activityData: [0, 1, 2, 3, 4, 5, 3, 2, 1, 0, 0, 3, 4, 2, 1, 5, 4, 0, 0, 0, 3, 4, 5, 3, 2, 1, 0,0, 1, 2, 3, 4, 5, 3, 2, 1, 0, 0, 3, 4, 2, 1, 5, 4, 0, 0, 0, 3, 4, 5, 3, 2, 1, 0,0, 1, 2, 3, 4, 5, 3, 2, 1, 0, 0, 3, 4, 2, 1, 5, 4, 0, 0, 0, 3, 4, 5, 3, 2, 1, 0,0, 1, 2, 3, 4, 5, 3, 2, 1, 0, 0, 3, 4, 2, 1, 5, 4, 0, 0, 0, 3, 4, 5, 3, 2, 1, 0,0, 1, 2, 3, 4, 5, 3, 2, 1, 0, 0, 3, 4, 2, 1, 5, 4, 0, 0, 0, 3, 4, 5, 3, 2, 1, 0]),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Recent Activities',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                return _buildActivityCard(
                  title: 'Joined the "Flutter Devs" Community',
                  description:
                      'Became an active member of the Flutter developers group.',
                  timestamp: '2 days ago',
                );
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, Color color) {
    return Card(
      color: Color(0xFF2C2C3E),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        width: 150,
        height: 125,
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: TextStyle(
                color: color,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAchievementBadge(String label, Color color) {
    return Chip(
      backgroundColor: Color(0xFF2C2C3E),
      avatar: CircleAvatar(
        backgroundColor: color,
        radius: 12,
      ),
      label: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildActivityCard({
    required String title,
    required String description,
    required String timestamp,
  }) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: Color(0xFF2C2C3E),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 8),
            Text(
              timestamp,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomBarGraph extends StatelessWidget {
  final Map<String, int> problemStats;

  const CustomBarGraph({
    Key? key,
    required this.problemStats,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sortedStats = problemStats.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final maxValue = problemStats.values.reduce((a, b) => a > b ? a : b);

    return Card(
      color: Color(0xFF2C2C3E),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Problems Solved by Category",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 16),
            ...sortedStats.map((entry) {
              final category = entry.key;
              final value = entry.value;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        category,
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        '$value',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  CustomPaint(
                    size: Size(double.infinity, 16),
                    painter: BarPainter(
                      value: value,
                      maxValue: maxValue,
                      color: Colors.purple,
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}

class BarPainter extends CustomPainter {
  final int value;
  final int maxValue;
  final Color color;

  BarPainter({
    required this.value,
    required this.maxValue,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paintBackground = Paint()
      ..color = Colors.grey.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    final paintBar = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Draw background bar
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(8),
      ),
      paintBackground,
    );

    // Draw filled bar proportional to the value
    final barWidth = (value / maxValue) * size.width;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, barWidth, size.height),
        Radius.circular(8),
      ),
      paintBar,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class ActivityStreakComponent extends StatelessWidget {
  final List<int> activityData; // Activity data (values between 0 and 5)

  ActivityStreakComponent({required this.activityData});

  // Color intensities for activity levels (0 to 5)
  final List<Color> activityColors = [
    Colors.grey[800]!, // Level 0: No activity (dark)
    Colors.green[100]!, // Level 1: Low activity (light green)
    Colors.green[200]!, // Level 2: Slightly more activity
    Colors.green[300]!, // Level 3: Moderate activity
    Colors.green[400]!, // Level 4: High activity
    Colors.green[600]!, // Level 5: Max activity (dark green)
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Activity Streak',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          // Grid to represent activity streak
          GridView.builder(
            shrinkWrap: true, // To prevent grid from expanding infinitely
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 30, // 7 days in a week
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: activityData.length,
            itemBuilder: (context, index) {
              int activityLevel = activityData[index];
              return Container(
                decoration: BoxDecoration(
                  color: activityColors[activityLevel], // Color based on activity level
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}