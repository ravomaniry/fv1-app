import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fv1/app.dart';
import 'package:fv1/models/chapter.dart';
import 'package:fv1/models/progress.dart';
import 'package:fv1/models/section.dart';
import 'package:fv1/models/teaching.dart';
import 'package:fv1/providers/create.dart';
import 'package:fv1/ui/screens/chapter.dart';
import 'package:fv1/ui/screens/teaching_summary.dart';
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
              ChapterModel(
                'TC22',
                [
                  SectionModel(
                    'SC211 title',
                    'SC211 content',
                    'http://fv1.com/1.wav',
                  ),
                  SectionModel(
                    'SC212 title',
                    'SC212 content',
                    'http://fv1.com/2.wav',
                  ),
                ],
                [],
              ),
              ChapterModel(
                'TC23',
                [],
                [],
              ),
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
    // Open teaching
    await tapByKey(tester, const Key('OpenTeaching1'));
    await tick(tester, 5);
    // Select chapter manually
    await tapByText(tester, 'TC12');
    expect(findTextWidget(tester, 'ChapterTitle').data, 'TC12');
    // All chapters are completed
    // -> Continue goes to first chapter
    await tapByKey(tester, ChapterScreen.backButtonKey, 2);
    await tick(tester, 5);
    await tapByKey(tester, ContinueButton.buttonKey);
    expect(findTextWidget(tester, 'ChapterTitle').data, 'TC11');
    // Some chapters are not completed
    // -> Resume to the next chapter
    await tapByKey(tester, ChapterScreen.backButtonKey, 2);
    await tapByKey(tester, TeachingSummaryScreen.backButtonKey, 2);
    await tapByKey(tester, const Key('OpenTeaching2'), 5);
    await tapByKey(tester, ContinueButton.buttonKey, 5);
    expect(findTextWidget(tester, 'ChapterTitle').data, 'TC22');
    // Render content
    expect(find.text('SC211 title'), findsOneWidget);
    expect(find.text('SC211 content'), findsOneWidget);
    expect(find.text('SC212 title'), findsOneWidget);
    expect(find.text('SC212 content'), findsOneWidget);
    // Audio player
  });
}
