import 'package:flutter/material.dart';
import 'package:fv1/mocks/test_chapter.dart';
import 'package:fv1/mocks/test_quiz.dart';
import 'package:fv1/ui/screens/score.dart';
import 'package:fv1/ui/widgets/app_bar.dart';
import 'package:fv1/ui/widgets/continue_button.dart';
import 'package:fv1/ui/widgets/h1.dart';
import 'package:fv1/ui/widgets/quiz_item.dart';
import 'package:fv1/utils/router.dart';

class QuizScreen extends StatelessWidget {
  static const route = '/quiz';

  const QuizScreen({super.key});

  void _goToScore(BuildContext context) {
    pushOnTopOfHome(context, ScoreScreen.route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Column(
        children: [
          ScreenH1(testChapter.title),
          Expanded(
            child: ListView(
              children: [
                for (final q in testQuestions)
                  QuizItemWidget(question: q, value: '', onChanged: (_) {})
              ],
            ),
          ),
          ContinueButton(onPressed: () => _goToScore(context))
        ],
      ),
    );
  }
}
