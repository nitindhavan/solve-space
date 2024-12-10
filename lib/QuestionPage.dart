import 'package:flutter/material.dart';

class QuestionPage extends StatefulWidget {
  final String questionTitle;
  final String questionDescription;

  QuestionPage({required this.questionTitle, required this.questionDescription});

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  int questionUpvotes = 10;  // Example initial upvotes
  int questionDownvotes = 2; // Example initial downvotes

  // List of answers and their votes
  List<Map<String, dynamic>> answers = [
    {
      'answer': 'Use a state management solution like Provider or Riverpod.',
      'upvotes': 5,
      'downvotes': 0,
    },
    {
      'answer': 'Try using the InheritedWidget for simple state management.',
      'upvotes': 2,
      'downvotes': 1,
    },
  ];

  void _upvoteQuestion() {
    setState(() {
      questionUpvotes++;
    });
  }

  void _downvoteQuestion() {
    setState(() {
      questionDownvotes++;
    });
  }

  void _upvoteAnswer(int index) {
    setState(() {
      answers[index]['upvotes']++;
    });
  }

  void _downvoteAnswer(int index) {
    setState(() {
      answers[index]['downvotes']++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E1E2E),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Question Title and Description
            Text(
              widget.questionTitle,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Text(
              widget.questionDescription,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
            SizedBox(height: 20),

            // Upvote/Downvote System for Question
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.thumb_up, color: Colors.green),
                  onPressed: _upvoteQuestion,
                ),
                Text(
                  '$questionUpvotes',
                  style: TextStyle(color: Colors.white),
                ),
                IconButton(
                  icon: Icon(Icons.thumb_down, color: Colors.red),
                  onPressed: _downvoteQuestion,
                ),
                Text(
                  '$questionDownvotes',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Answers Section
            Text(
              'Answers:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),

            // Display answers
            Expanded(
              child: ListView.builder(
                itemCount: answers.length,
                itemBuilder: (context, index) {
                  return _buildAnswer(
                    answerText: answers[index]['answer'],
                    upvotes: answers[index]['upvotes'],
                    downvotes: answers[index]['downvotes'],
                    index: index,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswer({
    required String answerText,
    required int upvotes,
    required int downvotes,
    required int index,
  }) {
    return Card(
      color: Color(0xFF2C2C3E),
      margin: EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              answerText,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.thumb_up, color: Colors.green),
                  onPressed: () => _upvoteAnswer(index),
                ),
                Text(
                  '$upvotes',
                  style: TextStyle(color: Colors.white),
                ),
                IconButton(
                  icon: Icon(Icons.thumb_down, color: Colors.red),
                  onPressed: () => _downvoteAnswer(index),
                ),
                Text(
                  '$downvotes',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
