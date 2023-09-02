import 'package:flutter/material.dart';
import 'package:fv1/providers/app_state.dart';
import 'package:fv1/providers/browser_state.dart';
import 'package:fv1/ui/router_utils.dart';
import 'package:fv1/ui/screens/quiz.dart';
import 'package:fv1/ui/widgets/app_container.dart';
import 'package:fv1/ui/widgets/chapter_section.dart';
import 'package:fv1/ui/widgets/continue_button.dart';
import 'package:fv1/ui/widgets/loader.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../widgets/h1.dart';

class ChapterScreen extends StatelessWidget {
  static const route = '/chapter';
  static const backButtonKey = Key('ChapterBackButton');

  const ChapterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<AppState, BrowserState>(
      builder: (_, appState, state, __) => _ChapterScreenBody(appState, state),
    );
  }
}

class _ChapterScreenBody extends StatelessWidget {
  final AppState _appState;
  final BrowserState _state;

  const _ChapterScreenBody(this._appState, this._state);

  void _onContinue(BuildContext context) {
    GoRouter.of(context).pushReplacementNamed(
      QuizScreen.route,
      pathParameters: GoRouterState.of(context).pathParameters,
    );
  }

  @override
  Widget build(BuildContext context) {
    final chapter = _state.getActiveChapter(readChapterIndex(context));
    return AppContainer(
      backButton: true,
      backButtonKey: ChapterScreen.backButtonKey,
      body: WrapInLoader(
        isReady: chapter != null,
        builder: () {
          return Column(
            children: [
              ScreenH1(
                chapter!.title,
                textKey: const Key('ChapterTitle'),
              ),
              Expanded(
                child: ListView(
                  children: [
                    for (final section in chapter.sections)
                      SectionWidget(section),
                  ],
                ),
              ),
              ContinueButton(
                label: _appState.texts.continueButton,
                onPressed: () => _onContinue(context),
              ),
            ],
          );
        },
      ),
    );
  }
}
