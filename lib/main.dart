import 'package:flutter/material.dart';
import 'package:fv1/ui/screens/chapter.dart';
import 'package:fv1/ui/screens/explorer.dart';
import 'package:fv1/ui/screens/home.dart';
import 'package:fv1/ui/screens/quiz.dart';
import 'package:fv1/ui/screens/score.dart';
import 'package:fv1/ui/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitiavana voalohany',
      theme: createTheme(),
      initialRoute: HomeScreen.route,
      routes: {
        HomeScreen.route: (_) => const HomeScreen(),
        ExplorerScreen.route: (_) => const ExplorerScreen(),
        ChapterScreen.route: (_) => const ChapterScreen(),
        QuizScreen.route: (_) => const QuizScreen(),
        ScoreScreen.route: (_) => const ScoreScreen(),
      },
    );
  }
}