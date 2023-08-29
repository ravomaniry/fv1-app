import 'package:flutter/material.dart';
import 'package:fv1/mocks/test_chapter.dart';
import 'package:fv1/ui/screens/chapter.dart';
import 'package:fv1/ui/widgets/app_container.dart';
import 'package:fv1/ui/widgets/continue_button.dart';
import 'package:fv1/ui/widgets/h1.dart';
import 'package:fv1/utils/router.dart';

class ScoreScreen extends StatelessWidget {
  static const route = '/score';

  const ScoreScreen({super.key});

  _goToChapter(BuildContext context) {
    pushOnTopOfHome(context, ChapterScreen.route);
  }

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      body: Column(
        children: [
          ScreenH1(testChapter.title),
          const Expanded(
            child: Center(
              child: Text('Score: 80/10'),
            ),
          ),
          ContinueButton(onPressed: () => _goToChapter(context))
        ],
      ),
    );
  }
}
