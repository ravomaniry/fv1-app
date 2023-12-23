import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fv1/app.dart';
import 'package:fv1/models/chapter.dart';
import 'package:fv1/models/chapter_score.dart';
import 'package:fv1/models/progress.dart';
import 'package:fv1/models/quiz_question.dart';
import 'package:fv1/models/section.dart';
import 'package:fv1/models/teaching.dart';
import 'package:fv1/models/texts.dart';
import 'package:fv1/models/user.dart';
import 'package:fv1/providers/create.dart';
import 'package:fv1/services/audio_player/player_stream_data.dart';
import 'package:fv1/ui/screens/chapter.dart';
import 'package:fv1/ui/screens/teaching_summary.dart';
import 'package:fv1/ui/widgets/audio_player.dart';
import 'package:fv1/ui/widgets/continue_button.dart';
import 'package:mockito/mockito.dart';

import 'api_client_test.mocks.dart';
import 'home_screen_test.mocks.dart';
import 'utils/tick.dart';

void main() {
  testWidgets('Open chapter and complete Quiz', (tester) async {
    final playerStreamCtr = StreamController<PlayerStreamData>();
    final playerDataStream = playerStreamCtr.stream.asBroadcastStream();
    final audioPlayer = MockAppAudioPlayer();
    when(audioPlayer.dataStream).thenAnswer((_) => playerDataStream);
    final dtService = MockDateTimeService();
    final now = DateTime.now();
    when(dtService.now()).thenReturn(now);
    final dataService = MockAbstractDataService();
    when(dataService.sync()).thenAnswer((_) async {});
    final progresses = [
      ProgressModel(
        id: 10,
        clientTimestamp: 0,
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
          ChapterScore(correctAnswersPercentage: 1),
        ],
      ),
      ProgressModel(
        id: 20,
        clientTimestamp: 0,
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
                  subtitle: 'SC211 title',
                  verses: 'SC211 verses',
                  comment: 'SC211 content',
                  audioId: '1',
                ),
                SectionModel(
                  subtitle: 'SC212 title',
                  comment: 'SC212 content',
                  verses: 'SC212 verses',
                  audioId: '2',
                ),
              ],
              [
                QuizQuestionModel('q1', 'Q1?', ['c1', 'c11'], 0),
                QuizQuestionModel('q2', 'Q2?', ['c2', 'c22'], 0),
                QuizQuestionModel('q3', 'Q3?', ['c3', 'c33'], 1),
              ],
            ),
            ChapterModel(
              'TC23',
              [
                SectionModel(
                  subtitle: 'SC231 title',
                  verses: 'SC231 verses',
                  comment: 'SC231 content',
                  audioId: '3',
                ),
              ],
              [
                QuizQuestionModel('a', 'A?', ['x', 'y'], 0),
              ],
            ),
          ],
        ),
        scores: [
          ChapterScore(correctAnswersPercentage: 0.8),
          ChapterScore(correctAnswersPercentage: 0.1),
        ],
      ),
    ];
    when(dataService.loadProgresses()).thenAnswer((_) async => progresses);
    final storage = MockStorageService();
    when(storage.getUser()).thenAnswer((_) => UserModel(1, 'A'));
    when(storage.isHelpViewed()).thenReturn(true);
    final providers = createProviders(
      dataService,
      audioPlayer,
      dtService,
      storage,
      MockAuthService(),
    );
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
    expect(getMarkdownData(tester, 'Verse0'), 'SC211 verses');
    expect(getMarkdownData(tester, 'Comment1'), 'SC212 content');
    expect(find.text('SC212 title'), findsOneWidget);
    expect(getMarkdownData(tester, 'Comment1'), 'SC212 content');
    // Audio player
    when(dataService.getAudioUrl('1')).thenAnswer((_) async => 'http://1.wav');
    when(dataService.getAudioUrl('2')).thenAnswer((_) async => 'http://2.wav');
    await tapByStringKey(tester, 'PlayButton0', 5);
    expect(find.byKey(AudioPlayerWidget.playerKey), findsOneWidget);
    expect(find.byKey(const Key('PlayingIcon0')), findsOneWidget);
    verify(audioPlayer.loadAndPlay('http://1.wav')).called(1);
    await tapByStringKey(tester, 'PlayButton1', 5);
    expect(find.byKey(const Key('PlayingIcon1')), findsOneWidget);
    verify(audioPlayer.loadAndPlay('http://2.wav')).called(1);
    // Audio player error
    final streamData = JustAudioStreamData();
    streamData.playerState = InternalPlayerState.error;
    playerStreamCtr.add(streamData);
    await tick(tester, 1);
    expect(find.text(mgTexts.errorAudioPlayer), findsOneWidget);
    await tapByStringKey(tester, 'DismissErrorButton', 1);
    expect(find.text(mgTexts.errorAudioPlayer), findsNothing);
    expect(find.byKey(AudioPlayerWidget.playerKey), findsNothing);
    // Notify audio player when widget is unmounted
    verify(audioPlayer.onPlayerUnmounted()).called(1);
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
    expect(findTextWidget(tester, 'WAQuestion0').data, '2. Q2?');
    expect(findTextWidget(tester, 'WAGivenAnswer0').data, 'c22');
    expect(findTextWidget(tester, 'WACorrectAnswer0').data, 'c2');
    expect(findTextWidget(tester, 'WAQuestion1').data, '3. Q3?');
    expect(findTextWidget(tester, 'WAGivenAnswer1').data, 'c3');
    expect(findTextWidget(tester, 'WACorrectAnswer1').data, 'c33');
    // Save progress
    verify(dataService.saveProgress(ProgressModel(
      id: 20,
      teaching: progresses[1].teaching,
      clientTimestamp: now.millisecondsSinceEpoch ~/ 1000,
      scores: [
        ChapterScore(correctAnswersPercentage: 0.8),
        ChapterScore(correctAnswersPercentage: 0.33),
      ],
    ))).called(1);
    // Go to next chapter
    when(dataService.getAudioUrl('3')).thenAnswer((_) async => 'http://3.wav');
    await tapByKey(tester, ContinueButton.buttonKey, 5);
    expect(findTextWidget(tester, 'ChapterTitle').data, 'TC23');
    expect(find.text('SC231 title'), findsOneWidget);
    // Play audio
    expect(find.byKey(AudioPlayerWidget.playerKey), findsNothing);
    await tapByStringKey(tester, 'PlayButton0', 5);
    verify(audioPlayer.loadAndPlay('http://3.wav')).called(1);
    // Go to quiz: notify audio player
    clearInteractions(dataService);
    await tapByKey(tester, ContinueButton.buttonKey, 5);
    verify(audioPlayer.onPlayerUnmounted()).called(1);
    // Submit quiz
    await tapByText(tester, 'x');
    await tapByKey(tester, ContinueButton.buttonKey, 5);
    // Save data and display score
    verify(dataService.saveProgress(ProgressModel(
      id: 20,
      teaching: progresses[1].teaching,
      clientTimestamp: now.millisecondsSinceEpoch ~/ 1000,
      scores: [
        ChapterScore(correctAnswersPercentage: 0.8),
        ChapterScore(correctAnswersPercentage: 0.33),
        ChapterScore(correctAnswersPercentage: 1),
      ],
    ))).called(1);
    expect(findTextWidget(tester, 'Score').data, '${mgTexts.score}: 1/1');
    // Teaching is finished -> Continue goes to summary
    await tapByKey(tester, ContinueButton.buttonKey, 5);
    expect(find.byKey(TeachingSummaryScreen.backButtonKey), findsOneWidget);
    // Update statistics
    expect(find.byKey(const Key('DoneIcon0')), findsOneWidget);
    expect(find.byKey(const Key('DoneIcon1')), findsNothing);
    expect(find.byKey(const Key('DoneIcon2')), findsOneWidget);
  });
}
