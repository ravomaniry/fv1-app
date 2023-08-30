import 'package:flutter/material.dart';
import 'package:fv1/mocks/test_chapter.dart';
import 'package:fv1/models/chapter.dart';
import 'package:fv1/ui/screens/quiz.dart';
import 'package:fv1/ui/widgets/app_container.dart';
import 'package:fv1/ui/widgets/chapter_section.dart';
import 'package:fv1/ui/widgets/continue_button.dart';

import '../widgets/h1.dart';

class ChapterScreen extends StatelessWidget {
  static const route = '/chapter';

  const ChapterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _ChapterScreenBody(testChapter);
  }
}

class _ChapterScreenBody extends StatelessWidget {
  final ChapterModel _chapter;

  const _ChapterScreenBody(this._chapter);

  void _onContinue(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(QuizScreen.route);
  }

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      body: Column(
        children: [
          ScreenH1(_chapter.title),
          Expanded(
            child: ListView(
              children: [
                for (final section in _chapter.sections) SectionWidget(section),
              ],
            ),
          ),
          ContinueButton(onPressed: () => _onContinue(context)),
        ],
      ),
    );
  }
}
