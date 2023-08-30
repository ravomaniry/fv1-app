import 'package:flutter/material.dart';
import 'package:fv1/ui/screens/chapter.dart';
import 'package:fv1/ui/screens/explorer.dart';
import 'package:fv1/ui/screens/home.dart';
import 'package:fv1/ui/screens/quiz.dart';
import 'package:fv1/ui/screens/score.dart';
import 'package:fv1/ui/screens/teaching_summary.dart';
import 'package:fv1/ui/theme.dart';
import 'package:provider/provider.dart';

class Fv1App extends StatelessWidget {
  final List<ChangeNotifierProvider<ChangeNotifier>> _providers;

  const Fv1App(this._providers, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: _providers,
      child: MaterialApp(
        title: 'Fitiavana voalohany',
        theme: createTheme(),
        initialRoute: HomeScreen.route,
        routes: {
          HomeScreen.route: (_) => const HomeScreen(),
          ExplorerScreen.route: (_) => const ExplorerScreen(),
          TeachingSummaryScreen.route: (_) => const TeachingSummaryScreen(),
          ChapterScreen.route: (_) => const ChapterScreen(),
          QuizScreen.route: (_) => const QuizScreen(),
          ScoreScreen.route: (_) => const ScoreScreen(),
        },
      ),
    );
  }
}
