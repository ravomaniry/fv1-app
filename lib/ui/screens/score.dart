import 'package:flutter/material.dart';
import 'package:fv1/mocks/test_chapter.dart';
import 'package:fv1/providers/browser_state.dart';
import 'package:fv1/ui/router_utils.dart';
import 'package:fv1/ui/screens/chapter.dart';
import 'package:fv1/ui/screens/teaching_summary.dart';
import 'package:fv1/ui/widgets/app_container.dart';
import 'package:fv1/ui/widgets/continue_button.dart';
import 'package:fv1/ui/widgets/h1.dart';
import 'package:fv1/ui/widgets/loader.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ScoreScreen extends StatelessWidget {
  static const route = '/score';

  const ScoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BrowserState>(
      builder: (_, state, __) => _Body(state),
    );
  }
}

class _Body extends StatelessWidget {
  final BrowserState _state;

  const _Body(this._state);

  void _onContinue(BuildContext context) {
    final chapterIndex = readChapterIndex(context);
    final nextChapter = _state.getActiveChapter(chapterIndex + 1);
    final params =
        Map<String, String>.from(GoRouterState.of(context).pathParameters);
    params.remove(chapterIndexKey);
    if (nextChapter == null) {
      GoRouter.of(context).pushReplacementNamed(
        TeachingSummaryScreen.route,
        pathParameters: params,
      );
    } else {
      params[chapterIndexKey] = '${chapterIndex + 1}';
      GoRouter.of(context).pushReplacementNamed(
        ChapterScreen.route,
        pathParameters: params,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final chapter = _state.getActiveChapter(readChapterIndex(context));
    return AppContainer(
      body: WrapInLoader(
        isReady: chapter != null,
        builder: () => Column(
          children: [
            ScreenH1(testChapter.title),
            const Expanded(
              child: Center(
                child: Text('Score: 80/10'),
              ),
            ),
            ContinueButton(onPressed: () => _onContinue(context))
          ],
        ),
      ),
    );
  }
}
