import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:solvespace/utils/apiconfig.dart';

class PostQuestionPage extends StatelessWidget {
  final List<String> categories = ['Developer', 'HR', 'Design', 'System', 'Cloud'];
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController tagsController = TextEditingController();

  Future<void> postQuestion(String title, String description, String category, String tags) async {
    const String apiUrl = '${ApiConfig.baseUrlApp}api/questions/ask';
    const String userId = '675725dce320c7e635d9881d'; // Replace with actual constant userId

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'mainQuestion': title,
          'description': description,
          'tags': tags.split(',').map((tag) => tag.trim()).toList(),
          'userId': userId,
        }),
      );

      if (response.statusCode == 201) {
        final responseBody = jsonDecode(response.body);
        print('Question posted successfully: ${responseBody['message']}');
      } else {
        print('Failed to post question: ${response.body}');
      }
    } catch (e) {
      print('Error posting question: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    String selectedCategory = '';

    return Scaffold(
      backgroundColor: Color(0xFF1E1E2E),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Question Title",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 8),
              TextField(
                controller: titleController,
                style: TextStyle(color: Colors.white),
                maxLength: 100,
                decoration: InputDecoration(
                  hintText: "Enter a brief title for your question",
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Color(0xFF2C2C3E),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                "Description",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 8),
              TextField(
                controller: descriptionController,
                style: TextStyle(color: Colors.white),
                maxLines: 6,
                decoration: InputDecoration(
                  hintText: "Provide details about your question",
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Color(0xFF2C2C3E),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                "Tags (optional)",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 8),
              TextField(
                controller: tagsController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Enter tags (e.g. Developement, UI, Design)",
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Color(0xFF2C2C3E),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                "Category",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 8),
              DropdownButtonFormField<String>(
                dropdownColor: Color(0xFF2C2C3E),
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFF2C2C3E),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                items: categories
                    .map((category) => DropdownMenuItem(
                  value: category,
                  child: Text(category),
                ))
                    .toList(),
                onChanged: (value) {
                  selectedCategory = value ?? '';
                },
                hint: Text("Select a category", style: TextStyle(color: Colors.grey)),
              ),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    postQuestion(
                      titleController.text.trim(),
                      descriptionController.text.trim(),
                      selectedCategory,
                      tagsController.text.trim(),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    "Post Question",
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
