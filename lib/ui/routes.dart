import 'package:flutter/material.dart';
import 'package:fv1/providers/app_state.dart';
import 'package:fv1/ui/screens/chapter.dart';
import 'package:fv1/ui/screens/explorer.dart';
import 'package:fv1/ui/screens/home.dart';
import 'package:fv1/ui/screens/login.dart';
import 'package:fv1/ui/screens/quiz.dart';
import 'package:fv1/ui/screens/register.dart';
import 'package:fv1/ui/screens/score.dart';
import 'package:fv1/ui/screens/teaching_summary.dart';
import 'package:fv1/ui/theme.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

abstract class Routes {
  static const home = '/';
  static const login = '/login';
  static const register = '/register';
  static const teachingSummary = 'teaching';
  static const chapter = 'chapter';
  static const quiz = 'quiz';
  static const score = 'score';
  static const explorer = 'explorer';
  static const teachingIdKey = 'teachingId';
  static const chapterIndexKey = 'chapterIndex';
}

int readTeachingId(BuildContext context) {
  return int.parse(
    GoRouterState.of(context).pathParameters[Routes.teachingIdKey]!,
  );
}

int readChapterIndex(BuildContext context) {
  return int.parse(
    GoRouterState.of(context).pathParameters[Routes.chapterIndexKey]!,
  );
}

class CreateRouter extends StatefulWidget {
  const CreateRouter({super.key});

  @override
  State<CreateRouter> createState() => _CreateRouterState();
}

class _CreateRouterState extends State<CreateRouter> {
  GoRouter? _routerConfig;

  GoRouter _createConfig() {
    final appState = context.read<AppState>();
    _routerConfig ??= GoRouter(
      redirect: (_, state) {
        final isOnAuthPage =
            state.fullPath == Routes.login || state.fullPath == Routes.register;
        if (appState.user == null) {
          return isOnAuthPage ? null : Routes.login;
        }
        return isOnAuthPage ? Routes.home : null;
      },
      refreshListenable: appState,
      routes: [
        GoRoute(
          path: Routes.home,
          builder: (_, __) => const HomeScreen(),
          routes: [
            GoRoute(
              name: Routes.teachingSummary,
              path: '${Routes.teachingSummary}/:${Routes.teachingIdKey}',
              builder: (_, __) => const TeachingSummaryScreen(),
              routes: [
                GoRoute(
                  name: Routes.chapter,
                  path: '${Routes.chapter}/:${Routes.chapterIndexKey}',
                  builder: (_, __) => const ChapterScreen(),
                  routes: [
                    GoRoute(
                      name: Routes.quiz,
                      path: Routes.quiz,
                      builder: (_, __) => const QuizScreen(),
                    ),
                    GoRoute(
                      name: Routes.score,
                      path: Routes.score,
                      builder: (_, __) => const ScoreScreen(),
                    ),
                  ],
                ),
              ],
            ),
            GoRoute(
              name: Routes.explorer,
              path: Routes.explorer,
              builder: (_, __) => const ExplorerScreen(),
            ),
          ],
        ),
        GoRoute(
            path: Routes.login,
            name: Routes.login,
            builder: (_, __) => const LoginScreen()),
        GoRoute(
          name: Routes.register,
          path: Routes.register,
          builder: (_, __) => const RegisterScreen(),
        ),
      ],
    );
    return _routerConfig!;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Fitiavana voalohany',
      theme: createTheme(),
      routerConfig: _createConfig(),
    );
  }
}
