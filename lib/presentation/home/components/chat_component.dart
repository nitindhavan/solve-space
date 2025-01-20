import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:solvespace/news.dart';
import 'package:solvespace/presentation/widgets/news_panels.dart';
import 'package:solvespace/presentation/widgets/question_panel.dart';
import 'dart:convert';
import 'package:solvespace/utils/apiconfig.dart';
import 'package:solvespace/utils/colors.dart';

import '../../../QuestionPage.dart';

class ChatBot extends StatefulWidget {
  @override
  _ChatBotState createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> _messages = []; // Store messages as a list of maps (message, isUser)

  String selectedQuestion = '6757d8f0c3a3ed0702fdbe84'; // Track the selected question for the QuestionPage
  String questionTitle = ''; // Variable to hold selected question's title
  String questionDescription = ''; // Variable to hold selected question's description

  // Send the message to backend and get a response
  Future<void> _sendMessage() async {
    if (_controller.text.isEmpty) return;

    // Add user's message to the chat
    setState(() {
      _messages.add({'message': _controller.text, 'isUser': true});
    });

    // Send the message to the backend
    final response = await _fetchResponse(_controller.text);

    // Simulate a delay for AI response
    Future.delayed(Duration(seconds: 1), () {
      if (response != null) {
        setState(() {
          _messages.add({'message': response, 'isUser': false}); // Bot's response
        });
      } else {
        setState(() {
          _messages.add({'message': "Sorry, I couldn't get an answer.", 'isUser': false}); // Default response
        });
      }
    });
  }

  // Function to send a request to the server
  Future<String?> _fetchResponse(String userInput) async {
    String encodedInput = Uri.encodeComponent(userInput);

    // Create the request body
    String body = 'question=$encodedInput';

    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.chatbotUrl}ask'), // Replace with your actual URL
        headers: {
          HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _controller.clear();
        print(data);
        return data['response'] ?? 'No answer found';
      } else {
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  // Build the chat bubble (user or bot message)
  Widget _buildChatBubble(String message, bool isUser) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isUser ? Colors.purple : Colors.grey[700],
          borderRadius: BorderRadius.circular(8),
            boxShadow: [BoxShadow(color: Colors.black,blurRadius: 10)]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                text: message.replaceAll(r'\n', '\n'),
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              softWrap: true,
            ),
            if(!isUser)Container(
              margin: EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: AppColor.primaryColor,
              ),
              padding: const EdgeInsets.all(8.0),
              child: TextButton(onPressed: (){}, child: Text('Post to community',style: TextStyle(color: Colors.white),)),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var page = QuestionPage(
      questionTitle: questionTitle,
      questionDescription: questionDescription,
      questionId: selectedQuestion,
    );

    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: AppColor.primaryColor,
                  boxShadow: [BoxShadow(color: Colors.black,blurRadius: 10)],
                borderRadius: BorderRadius.circular(8)
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.all(16),
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        var message = _messages[index];
                        return _buildChatBubble(message['message'], message['isUser']);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                color: AppColor.primaryColor,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [BoxShadow(color: Colors.black,blurRadius: 10)]
                            ),
                            child: TextField(
                              controller: _controller,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: 'Type your message...',
                                hintStyle: TextStyle(color: Colors.grey),
                                filled: true,
                                fillColor: AppColor.primaryColor,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(4),
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: AppColor.primaryColor,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [BoxShadow(color: Colors.black,blurRadius: 10)]
                          ),
                          child: IconButton(
                            icon: Icon(Icons.send, color: Colors.purple),
                            onPressed: _sendMessage,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              Expanded(
                child: QuestionPanel(
                  onMenuItemTap: (s, title, subtitle) {
                    setState(() {
                      // Update the selected question's title and description
                      questionTitle = title;
                      questionDescription = subtitle;
                      selectedQuestion = s;
                      // selected = 6; // Index of QuestionPage
                    });
                  },
                ),
              ),
              Expanded(child: NewsPanel(onMenuItemTap: (s,d,f){})),
            ],
          ),

        ],
      ),
      backgroundColor: Color(0xFF1E1E2E), // Dark background
    );
  }
}
