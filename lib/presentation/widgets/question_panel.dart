import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:solvespace/utils/apiconfig.dart';

class QuestionPanel extends StatefulWidget {
  final Function(String,String,String) onMenuItemTap;

  QuestionPanel({
    required this.onMenuItemTap,
  });

  @override
  _QuestionPanelState createState() => _QuestionPanelState();
}

class _QuestionPanelState extends State<QuestionPanel> {
  List<dynamic> questions = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 4), (v){
      fetchQuestions();
    });
  }

  // Function to fetch questions from the API
  Future<void> fetchQuestions() async {
    try {
      final response = await http.get(Uri.parse('${ApiConfig.baseUrlApp}api/questions/getQuestions'));

      if (response.statusCode == 200) {
        print(response.body);
        setState(() {
          questions = json.decode(response.body)['questions'];
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load questions');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      // Handle error (e.g., show an error message)
      print('Error fetching questions: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Color(0xFF1E1E2E),
        boxShadow: [BoxShadow(color: Colors.black,blurRadius: 10)]
      ),// Background color to match the sidebar
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(Icons.question_answer, color: Colors.white, size: 28),
                SizedBox(width: 10),
                Text(
                  'Top Questions',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                ),
                Spacer(),
                Text('View All',style: TextStyle(color: Colors.white),),
              ],
            ),
          ),
          Divider(color: Colors.grey),
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator()) // Loading indicator
                : ListView.builder(
              itemCount: questions.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    widget.onMenuItemTap(questions[index]['_id'],questions[index]['mainQuestion'],questions[index]['description']); // Call the passed function
                  },
                  child: _buildQuestionItem(
                    question: questions[index]['mainQuestion'],
                    frequency: questions[index]['answers'].length, // Assuming frequency is the number of answers
                    upvotes: questions[index]['upvotes'].length, // Assuming upvotes is an array of users who upvoted
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionItem({
    required String question,
    required int frequency,
    required int upvotes,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Card(
        color: Color(0xFF2C2C3E), // Card background color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListTile(
          title: Text(
            question,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            maxLines: 1,
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Frequency: $frequency',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              Row(
                children: [
                  Icon(Icons.arrow_upward, color: Colors.yellow, size: 16),
                  SizedBox(width: 4),
                  Text(
                    '$upvotes',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        ),
      ),
    );
  }
}
