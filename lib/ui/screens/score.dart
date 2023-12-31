import 'package:flutter/material.dart';
import 'package:fv1/extensions/context.dart';
import 'package:fv1/models/chapter.dart';
import 'package:fv1/providers/app_state.dart';
import 'package:fv1/providers/browser_state.dart';
import 'package:fv1/ui/routes.dart';
import 'package:fv1/ui/widgets/app_card.dart';
import 'package:fv1/ui/widgets/app_container.dart';
import 'package:fv1/ui/widgets/continue_button.dart';
import 'package:fv1/ui/widgets/h1.dart';
import 'package:fv1/ui/widgets/h2.dart';
import 'package:fv1/ui/widgets/loader.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ScoreScreen extends StatelessWidget {
  const ScoreScreen({super.key});

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
    final chapterIndex = readChapterIndex(context);
    final nextChapter = _state.getActiveChapter(chapterIndex + 1);
    final params = Map<String, String>.from(
      GoRouterState.of(context).pathParameters,
    );
    params.remove(Routes.chapterIndexKey);
    if (nextChapter == null) {
      GoRouter.of(context).pushReplacementNamed(
        Routes.teachingSummary,
        pathParameters: params,
      );
    } else {
      params[Routes.chapterIndexKey] = '${chapterIndex + 1}';
      GoRouter.of(context).pushReplacementNamed(
        Routes.chapter,
        pathParameters: params,
      );
    }
  }

  Widget _buildScore(ChapterModel chapter, BuildContext context) {
    return ScreenH2(
      '${_appState.texts.score}: '
      '${chapter.questions.length - _state.wrongAnswers!.length}/'
      '${chapter.questions.length}',
      textKey: const Key('Score'),
      color: context.themePrimaryColor,
    );
  }

  Widget _buildScoreChart(ChapterModel chapter, BuildContext context) {
    final v = (chapter.questions.length - _state.wrongAnswers!.length) /
        chapter.questions.length;
    return CircularProgressIndicator(
      value: v,
      backgroundColor: context.themeSecondaryColor,
      color: context.themePrimaryColor,
    );
  }

  Widget _buildWrongAnswers(BuildContext context, ChapterModel chapter) {
    return _state.wrongAnswers?.isNotEmpty == true
        ? Expanded(
            child: ListView(
              children: [
                for (final (i, wa) in _state.wrongAnswers!.indexed)
                  ListTile(
                    title: Text(
                      '${wa.index + 1}. ${wa.question}',
                      key: Key('WAQuestion$i'),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          wa.givenAnswer,
                          style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            fontStyle: FontStyle.italic,
                            color: context.themeErrorColor,
                          ),
                          key: Key('WAGivenAnswer$i'),
                        ),
                        Text(
                          wa.correctAnswer,
                          key: Key('WACorrectAnswer$i'),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          )
        : Expanded(child: Container());
  }

  @override
  Widget build(BuildContext context) {
    final chapter = _state.getActiveChapter(readChapterIndex(context));
    return AppContainer(
      backButton: true,
      body: WrapInLoader(
        isReady: chapter != null && _state.wrongAnswers != null,
        builder: () => AppCard(
          padding: 8,
          child: Column(
            children: [
              ScreenH1(chapter!.title),
              _buildScoreChart(chapter, context),
              _buildScore(chapter, context),
              _buildWrongAnswers(context, chapter),
              ContinueButton(
                label: _appState.texts.continueButton,
                onPressed: () => _onContinue(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
