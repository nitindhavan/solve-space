import 'package:flutter/material.dart';
import 'package:solvespace/presentation/home/components/chat_component.dart';
import 'package:solvespace/news.dart';
import 'package:solvespace/community_component.dart';
import 'package:solvespace/presentation/home/screen/home_page.dart';
import 'package:solvespace/presentation/widgets/drawer.dart';
import 'package:solvespace/updates.dart';
import 'package:solvespace/profile_components.dart';
import 'package:solvespace/post_question.dart';
import 'package:solvespace/presentation/widgets/question_panel.dart';

import 'QuestionPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Solvespace',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: HomePage(),
    );
  }
}
