import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:solvespace/utils/apiconfig.dart';
import 'dart:convert';

import 'answers/answer.dart';

class QuestionPage extends StatefulWidget {
  final String questionTitle;
  final String questionDescription;
  final String questionId;
  final String userId ='6757d63af573306265204151';

  QuestionPage({
    required this.questionTitle,
    required this.questionDescription,
    required this.questionId,
  });

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  int questionUpvotes = 10;
  int questionDownvotes = 2;

  // List of answers and their votes
  List<Answer> answers = [

  ];

  TextEditingController _answerController = TextEditingController();

  // Upvote/Downvote logic for the question
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

  // Upvote/Downvote logic for the answers
  void _upvoteAnswer(int index) {
    setState(() {
      answers[index].upvotes+=1;
    });
  }

  void _downvoteAnswer(int index) {
    setState(() {
      answers[index].downvotes++;
    });
  }

  // Submit the answer to the API
  Future<void> _submitAnswer() async {
    String content = _answerController.text;
    if (content.isNotEmpty) {
      setState(() {
        answers.add(new Answer(answerId: '', content: content, upvotes: 0, downvotes: 0, userId: widget.userId));
      });
      _addKnowledgeEntry(widget.questionTitle, content);
      final url = Uri.parse('${ApiConfig.baseUrlApp}api/questions/answer'); // Replace with your API URL
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          'content': content,
          'questionId': widget.questionId,
          'userId': widget.userId,
        }),
      );

      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        print('Answer posted: ${data['answer']}');
        // You can now add the new answer to the list if needed
      } else {
        final errorData = json.decode(response.body);
        print('Error: ${errorData['message']}');
      }
    }
  }

  Future<void> _addKnowledgeEntry(String question,String answer) async {

    final String url = '${ApiConfig.chatbotUrl}add_knowledge_entry';  // Replace with your backend URL

    // Prepare the request payload
    final Map<String, dynamic> requestPayload = {
      'id': widget.questionId,  // You can dynamically generate the ID or use any logic for the ID
      'question': question,
      'answer': answer,
      'submitted_at': DateTime.now().toString()
    };

    try {
      // Make the POST request
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(requestPayload),
      );
    }catch(e){
      print("hello");
    }
      // Handle the response
  }

  Future<List<Answer>> fetchAnswers(String questionId) async {
    // Define the API URL (replace with your actual API URL)
    final url = '${ApiConfig.baseUrlApp}api/questions/answers';

    try {
      // Send a GET request to fetch answers
      final response = await http.post(
          headers: {'Content-Type': 'application/json'},
          body: json.encode({'questionId': widget.questionId.toString()}),
          Uri.parse(url)
      );

      print(response.body);
      // Check if the response status is OK (200)
      if (response.statusCode == 200) {
        // Decode the response body as JSON
        final Map<String, dynamic> data = json.decode(response.body);

        // Check if the response contains answers
        if (data['answers'] != null) {
          // Map the answers to the Answer model and return as a list
          List<Answer> answers = (data['answers'] as List)
              .map((answerJson) => Answer.fromJson(answerJson))
              .toList();
          return answers;
        } else {
          throw Exception('No answers found');
        }
      } else {
        throw Exception('Failed to load answers');
      }
    } catch (e) {
      print('Error fetching answers: $e');
      throw Exception('Error fetching answers');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E1E2E),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
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
              FutureBuilder<List<Answer>>(
                future: fetchAnswers(widget.questionId.toString()),
                builder: (context, snapshot) {
                  if(!snapshot.hasData) return Center(child: CircularProgressIndicator());
                  answers =[];
                  answers.addAll(snapshot.data!);
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: answers.length,
                    itemBuilder: (context, index) {
                      print(snapshot.data);
                      return _buildAnswer(
                        answerText: answers[index].content.replaceAll(r'\\n', '\n'),
                        upvotes: answers[index].upvotes,
                        downvotes: answers[index].downvotes,
                        index: index,
                      );
                    },
                  );
                }
              ),

              // Text field for submitting an answer
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: TextField(
                  controller: _answerController,
                  decoration: InputDecoration(
                    labelText: 'Write your answer...',
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: _submitAnswer,
                child: Text('Submit Answer'),
              ),
            ],
          ),
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
