import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fv1/app.dart';
import 'package:fv1/models/chapter.dart';
import 'package:fv1/models/progress.dart';
import 'package:fv1/models/quiz_question.dart';
import 'package:fv1/models/section.dart';
import 'package:fv1/models/teaching.dart';
import 'package:fv1/models/texts.dart';
import 'package:fv1/providers/create.dart';
import 'package:fv1/ui/screens/chapter.dart';
import 'package:fv1/ui/screens/teaching_summary.dart';
import 'package:fv1/ui/widgets/audio_player.dart';
import 'package:fv1/ui/widgets/continue_button.dart';
import 'package:mockito/mockito.dart';

import 'home_screen_test.mocks.dart';
import 'utils/tick.dart';

void main() {
  testWidgets('Open chapter and complete Quiz', (tester) async {
    final audioPlayer = MockAppAudioPlayer();
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
                  SectionModel('SC211 title', 'SC211 content', 1),
                  SectionModel('SC212 title', 'SC212 content', 2),
                ],
                [
                  QuizQuestionModel('q1', 'Q1?', ['c1', 'c11'], 'c1'),
                  QuizQuestionModel('q2', 'Q2?', ['c2', 'c22'], 'c2'),
                  QuizQuestionModel('q3', 'Q3?', ['c3', 'c33'], 'c33'),
                ],
              ),
              ChapterModel('TC23', [], []),
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
    final providers = createProviders(dataService, audioPlayer);
    await tester.pumpWidget(Fv1App(providers));
    await tick(tester);
    // Open teaching
    await tapByStringKey(tester, 'OpenTeaching1');
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
    await tapByStringKey(tester, 'OpenTeaching2', 5);
    await tapByKey(tester, ContinueButton.buttonKey, 5);
    expect(findTextWidget(tester, 'ChapterTitle').data, 'TC22');
    // Render content
    expect(find.text('SC211 title'), findsOneWidget);
    expect(find.text('SC211 content'), findsOneWidget);
    expect(find.text('SC212 title'), findsOneWidget);
    expect(find.text('SC212 content'), findsOneWidget);
    // Audio player
    when(dataService.getAudioUrl(1)).thenAnswer((_) async => 'http://1.wav');
    when(dataService.getAudioUrl(2)).thenAnswer((_) async => 'http://2.wav');
    await tapByStringKey(tester, 'PlayButton0', 5);
    expect(find.byKey(AudioPlayerWidget.playerKey), findsOneWidget);
    expect(find.byKey(const Key('PlayingIcon0')), findsOneWidget);
    verify(audioPlayer.load('http://1.wav')).called(1);
    await tapByStringKey(tester, 'PlayButton1', 5);
    expect(find.byKey(const Key('PlayingIcon1')), findsOneWidget);
    verify(audioPlayer.load('http://2.wav')).called(1);
    // Quiz
    await tapByKey(tester, ContinueButton.buttonKey, 5);
    // Render questions
    expect(find.text('1. Q1?'), findsOneWidget);
    expect(find.text('2. Q2?'), findsOneWidget);
    expect(find.text('3. Q3?'), findsOneWidget);
    // Fill form
    await tapByText(tester, 'c1', 5);
    await tapByKey(tester, ContinueButton.buttonKey, 5);
    expect(find.text(mgTexts.requiredFieldMessage), findsNWidgets(2));
    await tapByText(tester, 'c22', 5);
    await tapByText(tester, 'c3', 5);
    // Go to score page
    await tapByKey(tester, ContinueButton.buttonKey, 5);
    // Display score
    expect(findTextWidget(tester, 'Score').data, '${mgTexts.score}: 1/3');
    // Display errors
    expect(findTextWidget(tester, 'WAQuestion0').data, 'Q2?');
    expect(findTextWidget(tester, 'WAGivenAnswer0').data, 'c22');
    expect(findTextWidget(tester, 'WACorrectAnswer0').data, 'c2');
    expect(findTextWidget(tester, 'WAQuestion1').data, 'Q3?');
    expect(findTextWidget(tester, 'WAGivenAnswer1').data, 'c3');
    expect(findTextWidget(tester, 'WACorrectAnswer1').data, 'c33');
  });
}
