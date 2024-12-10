import 'package:flutter/material.dart';
import 'package:solvespace/QuestionPage.dart';
import 'package:solvespace/chat_component.dart';
import 'package:solvespace/community_component.dart';
import 'package:solvespace/header_bar.dart';
import 'package:solvespace/news.dart';
import 'package:solvespace/post_question.dart';
import 'package:solvespace/profile_components.dart';
import 'package:solvespace/right_slider_panel.dart';
import 'package:solvespace/sliderbar_menu.dart';
import 'package:solvespace/updates.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quirble UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selected=0;
  int selectedQuestion=0;
  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [ChatArea(),NewsPage(),CommunitiesPage(),UpdatesPage(),ProfileDashboardPage(),PostQuestionPage(),QuestionPage(questionTitle: 'This is the title for question', questionDescription: 'This is the description of the question')];
    return Scaffold(
      body: Row(
        children: [
          SidebarMenu(
              onMenuItemTap: (i){
                setState(() {
                  selected = i;
                });
              }, selectedIndex: 0,
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                    child: Row(
                      children: [Expanded(child: pages[selected]), RightSliderPanel(onMenuItemTap: (s){
                        setState(() {
                          selectedQuestion = s;
                          selected = 6;
                        });
                      },)],
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

