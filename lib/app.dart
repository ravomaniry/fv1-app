import 'package:flutter/material.dart';
import 'package:fv1/ui/router_utils.dart';
import 'package:fv1/ui/screens/chapter.dart';
import 'package:fv1/ui/screens/explorer.dart';
import 'package:fv1/ui/screens/home.dart';
import 'package:fv1/ui/screens/quiz.dart';
import 'package:fv1/ui/screens/score.dart';
import 'package:fv1/ui/screens/teaching_summary.dart';
import 'package:fv1/ui/theme.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

final _routeConfig = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (_, __) => const HomeScreen(),
      routes: [
        GoRoute(
          name: TeachingSummaryScreen.route,
          path: 'teaching/:$teachingIdKey',
          builder: (_, __) => const TeachingSummaryScreen(),
          routes: [
            GoRoute(
              name: ChapterScreen.route,
              path: 'chapter/:$chapterIndexKey',
              builder: (_, __) => const ChapterScreen(),
              routes: [
                GoRoute(
                  name: QuizScreen.route,
                  path: 'quiz',
                  builder: (_, __) => const QuizScreen(),
                ),
                GoRoute(
                  name: ScoreScreen.route,
                  path: 'score',
                  builder: (_, __) => const ScoreScreen(),
                ),
              ],
            ),
          ],
        ),
        GoRoute(
          name: ExplorerScreen.route,
          path: 'explorer',
          builder: (_, __) => const ExplorerScreen(),
        ),
      ],
    ),
  ],
);

class Fv1App extends StatelessWidget {
  final List<ChangeNotifierProvider<ChangeNotifier>> _providers;

  const Fv1App(this._providers, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: _providers,
      child: MaterialApp.router(
        title: 'Fitiavana voalohany',
        theme: createTheme(),
        routerConfig: _routeConfig,
      ),
    );
  }
}
