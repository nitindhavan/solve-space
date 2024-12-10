import 'package:flutter/material.dart';

class UpdatesPage extends StatelessWidget {
  final List<Map<String, String>> updates = [
    {
      'title': 'New Branch Opened',
      'description': 'We are excited to announce the opening of our new branch in New York City.',
      'timestamp': 'Dec 8, 2024, 10:00 AM',
      'image': 'https://via.placeholder.com/500'
    },
    {
      'title': 'Policy Update',
      'description': 'Our leave policy has been updated to provide more flexibility to employees.',
      'timestamp': 'Dec 5, 2024, 2:00 PM',
      'image': 'https://via.placeholder.com/500'
    },
    {
      'title': 'New CEO Announcement',
      'description': 'We welcome John Doe as the new CEO of the organization.',
      'timestamp': 'Dec 1, 2024, 9:00 AM',
    },
    {
      'title': 'Holiday Schedule Released',
      'description': 'Check out the updated holiday schedule for the year 2025.',
      'timestamp': 'Nov 30, 2024, 4:30 PM',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E1E2E),
      body: ListView.builder(
        itemCount: updates.length,
        itemBuilder: (context, index) {
          final update = updates[index];
          return _buildUpdateCard(
            title: update['title']!,
            description: update['description']!,
            timestamp: update['timestamp']!,
            imageUrl: update['image'], // May be null
          );
        },
      ),
    );
  }

  Widget _buildUpdateCard({
    required String title,
    required String description,
    required String timestamp,
    String? imageUrl,
  }) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      color: Color(0xFF2C2C3E),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            // Description
            Text(
              description,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 8),
            // Image (if available)
            if (imageUrl != null)
              Container(
                height: 200,
                width: double.infinity,
                margin: EdgeInsets.only(top: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            SizedBox(height: 8),
            // Timestamp
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
