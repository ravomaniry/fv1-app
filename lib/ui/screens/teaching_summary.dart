import 'package:flutter/material.dart';
import 'package:fv1/mocks/test_teaching.dart';
import 'package:fv1/models/chapter.dart';
import 'package:fv1/models/teaching.dart';
import 'package:fv1/ui/screens/chapter.dart';
import 'package:fv1/ui/widgets/app_container.dart';
import 'package:fv1/ui/widgets/continue_button.dart';
import 'package:fv1/ui/widgets/h1.dart';

class TeachingSummaryScreen extends StatelessWidget {
  static const route = '/teaching';

  const TeachingSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _ScreenBody(testTeaching);
  }
}

class _ScreenBody extends StatelessWidget {
  final TeachingModel _teaching;

  const _ScreenBody(this._teaching);

  void _onContinue(BuildContext context) {
    Navigator.of(context).pushNamed(ChapterScreen.route);
  }

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      body: Column(
        children: [
          ScreenH1(_teaching.title),
          Expanded(
            child: ListView(
              children: [
                for (final chapter in _teaching.chapters) _ChapterCard(chapter),
              ],
            ),
          ),
          ContinueButton(onPressed: () => _onContinue(context)),
        ],
      ),
    );
  }
}

class _ChapterCard extends StatelessWidget {
  final ChapterModel _chapter;

  const _ChapterCard(this._chapter);

  void _onSelected(BuildContext context) {
    Navigator.of(context).pushNamed(ChapterScreen.route);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(_chapter.title),
      onTap: () => _onSelected(context),
    );
  }
}
