import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fv1/providers/app_state.dart';
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

final _formKey = GlobalKey<FormBuilderState>();

class QuizScreen extends StatelessWidget {
  static const route = '/quiz';

  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<AppState, BrowserState>(
      builder: (_, appState, state, __) => _Body(appState, state),
    );
  }
}

class _Body extends StatelessWidget {
  final AppState _appState;
  final BrowserState _state;

  const _Body(this._appState, this._state);

  void _onContinue(BuildContext context) {
    final isValid = _formKey.currentState
        ?.saveAndValidate(autoScrollWhenFocusOnInvalid: true);
    if (isValid == true) {
      _state.submitQuiz(_formKey.currentState!.value);
      GoRouter.of(context).pushReplacementNamed(
        ScoreScreen.route,
        pathParameters: GoRouterState.of(context).pathParameters,
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
            ScreenH1(chapter!.title),
            FormBuilder(
              key: _formKey,
              child: Expanded(
                child: ListView(
                  children: [
                    Text(_appState.texts.quizHelp),
                    for (final (index, question) in chapter.questions.indexed)
                      QuizItemWidget(
                        texts: _appState.texts,
                        index: index,
                        question: question,
                        value: _state.getFormValue(question.key),
                      ),
                  ],
                ),
              ),
            ),
            ContinueButton(
              label: _appState.texts.continueButton,
              onPressed: () => _onContinue(context),
            ),
          ],
        ),
      ),
    );
  }
}
