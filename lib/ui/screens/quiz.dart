import 'package:flutter/material.dart';
import 'package:fv1/mocks/test_chapter.dart';
import 'package:fv1/mocks/test_quiz.dart';
import 'package:fv1/ui/screens/score.dart';
import 'package:fv1/ui/widgets/app_container.dart';
import 'package:fv1/ui/widgets/continue_button.dart';
import 'package:fv1/ui/widgets/h1.dart';
import 'package:fv1/ui/widgets/quiz_item.dart';
import 'package:fv1/utils/router.dart';

class QuizScreen extends StatefulWidget {
  static const route = '/quiz';

  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  Map<String, dynamic> formValues = {};

  void _onChanged(String name, dynamic value) {
    setState(() {
      formValues[name] = value;
    });
  }

  void _goToScore(BuildContext context) {
    pushOnTopOfHome(context, ScoreScreen.route);
  }

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      body: Column(
        children: [
          ScreenH1(testChapter.title),
          Expanded(
            child: ListView(
              children: [
                for (final q in testQuestions)
                  QuizItemWidget(
                    question: q,
                    value: formValues[q.key],
                    onChanged: (v) => _onChanged(q.key, v),
                  ),
              ],
            ),
          ),
          ContinueButton(onPressed: () => _goToScore(context))
        ],
      ),
    );
  }
}
