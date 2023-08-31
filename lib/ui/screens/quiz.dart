import 'package:flutter/material.dart';
import 'package:fv1/mocks/test_chapter.dart';
import 'package:fv1/providers/browser_state.dart';
import 'package:fv1/ui/router_utils.dart';
import 'package:fv1/ui/screens/score.dart';
import 'package:fv1/ui/widgets/app_container.dart';
import 'package:fv1/ui/widgets/continue_button.dart';
import 'package:fv1/ui/widgets/h1.dart';
import 'package:fv1/ui/widgets/loader.dart';
import 'package:fv1/ui/widgets/quiz_item.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class QuizScreen extends StatelessWidget {
  static const route = '/quiz';

  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BrowserState>(builder: (_, state, __) => _Body(state));
  }
}

class _Body extends StatelessWidget {
  final BrowserState _state;

  const _Body(this._state);

  void _onContinue(BuildContext context) {
    GoRouter.of(context).pushReplacementNamed(
      ScoreScreen.route,
      pathParameters: GoRouterState.of(context).pathParameters,
    );
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
            Expanded(
              child: ListView(
                children: [
                  for (final q in chapter!.questions)
                    QuizItemWidget(
                      question: q,
                      value: _state.getFormValue(q.key),
                      onChanged: (v) => _state.onFormValueChanged(q.key, v),
                    ),
                ],
              ),
            ),
            ContinueButton(onPressed: () => _onContinue(context))
          ],
        ),
      ),
    );
  }
}
