import 'package:flutter/material.dart';
import 'package:fv1/ui/screens/chapter.dart';
import 'package:fv1/ui/screens/explorer.dart';
import 'package:fv1/ui/screens/home.dart';
import 'package:fv1/ui/screens/teaching_summary.dart';
import 'package:fv1/ui/theme.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

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
        routerConfig: GoRouter(
          routes: [
            GoRoute(
              path: '/',
              builder: (_, __) => const HomeScreen(),
              routes: [
                GoRoute(
                  name: TeachingSummaryScreen.route,
                  path: 'teaching/:id',
                  builder: (_, state) => TeachingSummaryScreen(
                    id: int.parse(state.pathParameters['id']!),
                  ),
                  routes: [
                    GoRoute(
                      name: ChapterScreen.route,
                      path: 'chapter/:chapterIndex',
                      builder: (_, state) => ChapterScreen(
                        index: int.parse(state.pathParameters['chapterIndex']!),
                      ),
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
        ),
      ),
    );
  }
}
