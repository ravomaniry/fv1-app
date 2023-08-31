import 'package:flutter/material.dart';
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

  const ChapterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BrowserState>(
      builder: (_, state, __) => _ChapterScreenBody(state),
    );
  }
}

class _ChapterScreenBody extends StatelessWidget {
  final BrowserState _state;

  const _ChapterScreenBody(this._state);

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
      body: WrapInLoader(
        isReady: chapter != null,
        builder: () {
          return Column(
            children: [
              ScreenH1(chapter!.title),
              Expanded(
                child: ListView(
                  children: [
                    for (final section in chapter.sections)
                      SectionWidget(section),
                  ],
                ),
              ),
              ContinueButton(onPressed: () => _onContinue(context)),
            ],
          );
        },
      ),
    );
  }
}
