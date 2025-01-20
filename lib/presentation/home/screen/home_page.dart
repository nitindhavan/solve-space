import 'package:flutter/material.dart';
import 'package:solvespace/utils/colors.dart';

import '../../../../QuestionPage.dart';
import '../../widgets/drawer.dart';
import '../components/chat_component.dart';
import '../../../../community_component.dart';
import '../../../../news.dart';
import '../../../../post_question.dart';
import '../../../../profile_components.dart';
import '../../../../updates.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selected = 0; // To track selected menu item in the sidebar
  @override
  Widget build(BuildContext context) {
    // Initialize a default QuestionPage

    // List of pages to navigate between
    List<Widget> pages = [
      ChatBot(), // Chat page
      NewsPage(), // News page
      CommunitiesPage(), // Communities page
      UpdatesPage(), // Updates page
      ProfileDashboardPage(), // Profile page
      PostQuestionPage(), // Post question page// Default QuestionPage that will change based on selected question
    ];

    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Row(
        children: [
          CustomDrawer(onMenuItemTap: (i) {
            setState(() {
              selected = i;
            });
          },selectedIndex: 0,),
          Expanded(
            child: pages[selected],
          ),
        ],
      ),
    );
  }
}
