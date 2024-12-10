import 'package:flutter/material.dart';

class RightSliderPanel extends StatelessWidget {
  final Function(int) onMenuItemTap;

  RightSliderPanel({
    required this.onMenuItemTap,
  });

  final List<Map<String, dynamic>> questions = [
    {'question': 'How to use Flutter?', 'frequency': 5, 'upvotes': 12},
    {'question': 'What is Dart?', 'frequency': 3, 'upvotes': 8},
    {'question': 'How to create a widget in Flutter?', 'frequency': 4, 'upvotes': 15},
    {'question': 'What is a stateful widget?', 'frequency': 2, 'upvotes': 10},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      color: Color(0xFF1E1E2E), // Background color to match the sidebar
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(Icons.question_answer, color: Colors.white, size: 28),
                SizedBox(width: 10),
                Text(
                  'Questions',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Icon(Icons.search, color: Colors.white),
              ],
            ),
          ),
          Divider(color: Colors.grey),
          Expanded(
            child: ListView.builder(
              itemCount: questions.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    onMenuItemTap(index); // Call the passed function
                  },
                  child: _buildQuestionItem(
                    question: questions[index]['question'],
                    frequency: questions[index]['frequency'],
                    upvotes: questions[index]['upvotes'],
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
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
            ),
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
          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        ),
      ),
    );
  }
}
