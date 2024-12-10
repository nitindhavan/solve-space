import 'package:flutter/material.dart';

class NewsPage extends StatelessWidget {
  final List<Map<String, String>> newsArticles = [
    {
      'title': 'Breaking News: Flutter 3.0 Released!',
      'description': 'Flutter 3.0 brings significant improvements to app performance and support for new platforms.',
      'image': 'https://via.placeholder.com/500x300',
      'author': 'Flutter Dev',
      'time': '2 hours ago',
      'upvotes': '120'
    },
    {
      'title': 'Solve Space Launches New Feature',
      'description': 'The SolveSpace platform has introduced a new AI-powered bot to help users solve common issues.',
      'image': 'https://via.placeholder.com/500x300',
      'author': 'SolveSpace Team',
      'time': '5 hours ago',
      'upvotes': '85'
    },
    {
      'title': 'Community Growth in Solve Space',
      'description': 'Solve Space community has grown by 20% over the last month, thanks to its helpful and engaged user base.',
      'image': 'https://via.placeholder.com/500x300',
      'author': 'SolveSpace Team',
      'time': '1 day ago',
      'upvotes': '200'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E1E2E),
      body: ListView.builder(
        itemCount: newsArticles.length,
        itemBuilder: (context, index) {
          return _buildPostItem(
            title: newsArticles[index]['title']!,
            description: newsArticles[index]['description']!,
            imageUrl: newsArticles[index]['image']!,
            author: newsArticles[index]['author']!,
            time: newsArticles[index]['time']!,
            upvotes: newsArticles[index]['upvotes']!,
          );
        },
      ),
    );
  }

  Widget _buildPostItem({
    required String title,
    required String description,
    required String imageUrl,
    required String author,
    required String time,
    required String upvotes,
  }) {
    return Card(
      color: Color(0xFF2C2C3E), // Background color to match theme
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 6, // Slight shadow for a post-like look
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Author and Time
            Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundImage: NetworkImage('https://via.placeholder.com/50'), // Author's profile picture
                ),
                SizedBox(width: 10),
                Text(
                  author,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  time,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),

            // Post Title
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),

            // Post Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/images/ai.jpg',
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 12),

            // Post Description
            Text(
              description,
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 14,
                height: 1.5, // Adjust line height for readability
              ),
            ),
            SizedBox(height: 12),

            // Upvote and Interaction Section
            Row(
              children: [
                Icon(
                  Icons.thumb_up_alt_outlined,
                  color: Colors.grey,
                  size: 20,
                ),
                SizedBox(width: 5),
                Text(
                  '$upvotes Upvotes',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                Spacer(),
                Text(
                  'Comment',
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
