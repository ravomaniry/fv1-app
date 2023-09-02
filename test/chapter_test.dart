import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fv1/app.dart';
import 'package:fv1/models/chapter.dart';
import 'package:fv1/models/progress.dart';
import 'package:fv1/models/teaching.dart';
import 'package:fv1/providers/create.dart';
import 'package:fv1/ui/widgets/continue_button.dart';
import 'package:mockito/mockito.dart';

import 'home_screen_test.mocks.dart';
import 'utils/tick.dart';

void main() {
  testWidgets('Open chapter and complete Quiz', (tester) async {
    final dataService = MockAbstractDataService();
    when(dataService.sync()).thenAnswer((_) async {});
    when(dataService.loadProgresses()).thenAnswer(
      (_) async => [
        ProgressModel(
          teaching: TeachingModel(
            1,
            'T1',
            'ST1',
            [
              ChapterModel('TC11', [], []),
              ChapterModel('TC12', [], []),
            ],
          ),
          scores: [
            ChapterScore(correctAnswersPercentage: 1),
            ChapterScore(correctAnswersPercentage: 2),
          ],
          completionPercentage: 1,
        ),
        ProgressModel(
          teaching: TeachingModel(
            2,
            'T2',
            'ST2',
            [
              ChapterModel('TC21', [], []),
              ChapterModel('TC22', [], []),
            ],
          ),
          scores: [
            ChapterScore(correctAnswersPercentage: 0.8),
            ChapterScore(correctAnswersPercentage: 0.1),
          ],
          completionPercentage: 0.5,
        ),
      ],
    );
    final providers = createProviders(dataService);
    await tester.pumpWidget(Fv1App(providers));
    await tick(tester);
    // All chapters are completed
    // -> Continue goes to first chapter
    await tapByKey(tester, const Key('OpenTeaching1'));
    await tick(tester, 5);
    await tapByKey(tester, ContinueButton.buttonKey);
    expect(findTextWidget(tester, 'ChapterTitle').data, 'TC11');
  });
}
