import 'package:flutter/material.dart';
import 'package:fv1/mocks/test_chapter.dart';
import 'package:fv1/ui/screens/quiz.dart';
import 'package:fv1/ui/widgets/app_bar.dart';
import 'package:fv1/ui/widgets/chapter_section.dart';
import 'package:fv1/ui/widgets/continue_button.dart';
import 'package:fv1/utils/router.dart';

import '../widgets/h1.dart';

class ChapterScreen extends StatelessWidget {
  static const route = '/chapter';

  const ChapterScreen({super.key});

  void _goToChapter(BuildContext context) {
    pushOnTopOfHome(context, QuizScreen.route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const AppBarTitle()),
      body: Column(
        children: [
          ScreenH1(testChapter.title),
          for (final section in testChapter.sections) SectionWidget(section),
          Expanded(child: Container()),
          ContinueButton(onPressed: () => _goToChapter(context)),
        ],
      ),
    );
  }
}
