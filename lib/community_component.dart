import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CommunitiesPage extends StatefulWidget {
  @override
  _CommunitiesPageState createState() => _CommunitiesPageState();
}

class _CommunitiesPageState extends State<CommunitiesPage> {
  final List<String> categories = ['All', 'Developers', 'HR', 'Art', 'Designers', 'Marketing'];
  String selectedCategory = 'All';

  List<Map<String, dynamic>> communityPosts = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCommunityPosts();
  }

  Future<void> fetchCommunityPosts() async {
    final url = Uri.parse('http://localhost:3000/api/questions/getQuestions'); // Replace with your API endpoint
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['questions'];
        setState(() {
          communityPosts = data
              .map((post) => {
            'community': post['tags']?.join(', ') ?? 'General',
            'category': post['urgency'] ?? 'General',
            'title': post['mainQuestion'] ?? 'Untitled',
            'description': post['description'] ?? '',
            'image': post['images']?.isNotEmpty == true ? post['images'][0] : null,
            'upvotes': post['upvotes']?.length ?? 0,
            'downvotes': post['downvotes']?.length ?? 0,
          })
              .toList();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (error) {
      print('Error fetching data: $error');
      setState(() {
        isLoading = false;
      });
    }
  }


  List<Map<String, dynamic>> getFilteredPosts() {
    if (selectedCategory == 'All') {
      return communityPosts;
    } else {
      return communityPosts.where((post) => post['category'] == selectedCategory).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E1E2E),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          // Category Filter
          Container(
            height: 50,
            color: Color(0xFF1E1E2E),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategory = categories[index];
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    decoration: BoxDecoration(
                      color: selectedCategory == categories[index] ? Colors.purple : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.purple),
                    ),
                    child: Text(
                      categories[index],
                      style: TextStyle(
                        color: selectedCategory == categories[index] ? Colors.white : Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Posts
          Expanded(
            child: ListView.builder(
              itemCount: getFilteredPosts().length,
              itemBuilder: (context, index) {
                final post = getFilteredPosts()[index];
                return _buildInstagramPost(
                  community: post['community'] ?? 'Community',
                  title: post['title'] ?? 'No Title',
                  description: post['description'] ?? '',
                  upvotes: post['upvotes'] ?? 0,
                  downvotes: post['downvotes'] ?? 0,
                  imageUrl: post['image'],
                );
              },
            ),
          ),

        ],
      ),
    );
  }

  Widget _buildInstagramPost({
    required String community,
    required String title,
    required String description,
    required int upvotes,
    required int downvotes,
    String? imageUrl,
  }) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      color: Color(0xFF2C2C3E),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Post Header
          ListTile(
            leading: CircleAvatar(
              backgroundImage: imageUrl != null ? NetworkImage(imageUrl) : null,
              child: imageUrl == null ? Icon(Icons.image, color: Colors.grey) : null,
            ),
            title: Text(
              community,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              title,
              style: TextStyle(color: Colors.grey),
            ),
            trailing: Icon(Icons.more_vert, color: Colors.white),
          ),
          // Post Description
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              description,
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
          // Action Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Icon(Icons.arrow_upward, color: Colors.white),
                SizedBox(width: 8),
                Text('$upvotes', style: TextStyle(color: Colors.white)),
                SizedBox(width: 16),
                Icon(Icons.arrow_downward, color: Colors.white),
                SizedBox(width: 8),
                Text('$downvotes', style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

}
