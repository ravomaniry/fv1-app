import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fv1/app.dart';
import 'package:fv1/models/chapter.dart';
import 'package:fv1/models/chapter_score.dart';
import 'package:fv1/models/progress.dart';
import 'package:fv1/models/teaching.dart';
import 'package:fv1/models/user.dart';
import 'package:fv1/providers/create.dart';
import 'package:fv1/services/api_client/auth_service.dart';
import 'package:fv1/services/audio_player/audio_player.dart';
import 'package:fv1/services/data/data_service.dart';
import 'package:fv1/services/datetime/datetime_service.dart';
import 'package:fv1/ui/routes.dart';
import 'package:fv1/ui/screens/home.dart';
import 'package:fv1/ui/screens/teaching_summary.dart';
import 'package:fv1/ui/widgets/loader.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'api_client_test.mocks.dart';
@GenerateNiceMocks([
  MockSpec<AbstractDataService>(),
  MockSpec<AppAudioPlayer>(),
  MockSpec<DateTimeService>(),
  MockSpec<AuthService>(),
])
import 'home_screen_test.mocks.dart';
import 'utils/tick.dart';

void main() {
  List<ProgressModel> progresses = [];
  late MockAbstractDataService dataService;
  late List<ChangeNotifierProvider<ChangeNotifier>> providers;

  setUp(() {
    dataService = MockAbstractDataService();
    final storage = MockStorageService();
    when(dataService.sync()).thenAnswer(
      (_) => Future.delayed(const Duration(seconds: 1)),
    );
    when(dataService.loadProgresses()).thenAnswer((_) async => progresses);
    when(storage.getUser()).thenAnswer((_) => UserModel(1, 'User1'));
    providers = createProviders(
      dataService,
      MockAppAudioPlayer(),
      MockDateTimeService(),
      storage,
      MockAuthService(),
    );
  });

  testWidgets(
    'No saved progress: Display button to go to explorer',
    (tester) async {
      await tester.pumpWidget(Fv1App(providers));
      // Display loader before sync is done
      expect(find.byKey(WrapInLoader.loaderKey), findsOneWidget);
      expect(find.byKey(HomeScreen.searchButtonKey), findsNothing);
      // Display the buttons when sync is done
      await tick(tester, 2);
      expect(find.byKey(WrapInLoader.loaderKey), findsNothing);
      expect(find.byKey(HomeScreen.explorerHelpKey), findsOneWidget);
      expect(find.byKey(HomeScreen.searchButtonKey), findsOneWidget);
    },
  );

  testWidgets('Home to teaching summary', (tester) async {
    progresses = [
      ProgressModel(
        id: 10,
        clientTimestamp: 1000,
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
          ChapterScore(correctAnswersPercentage: 0.8),
          ChapterScore(correctAnswersPercentage: 0.1),
        ],
      ),
      ProgressModel(
        id: 20,
        clientTimestamp: 1000,
        teaching: TeachingModel(
          2,
          'T2',
          'ST2',
          [ChapterModel('TC2', [], [])],
        ),
        scores: [],
      ),
    ];
    await tester.pumpWidget(Fv1App(providers));
    await tick(tester, 2);
    // Render buttons
    expect(find.byKey(HomeScreen.searchButtonKey), findsOneWidget);
    expect(find.byKey(HomeScreen.syncLoaderKey), findsNothing);
    // Render teachings
    expect(findTextWidget(tester, 'HomeTeachingTitle1').data, 'T1');
    expect(findTextWidget(tester, 'HomeTeachingSubtitle1').data, 'ST1');
    expect(findTextWidget(tester, 'HomeTeachingTitle2').data, 'T2');
    expect(findTextWidget(tester, 'HomeTeachingSubtitle2').data, 'ST2');
    // Progress
    expect(findLPIndicator(tester, 'HomeScreenProgress1').value, 0.5);
    expect(findLPIndicator(tester, 'HomeScreenProgress2').value, 0);
    // Teaching summary 1
    await tapByStringKey(tester, 'OpenTeaching1');
    await tick(tester, 2);
    expect(find.byKey(const Key(Routes.teachingSummary)), findsOneWidget);
    expect(find.byKey(TeachingSummaryScreen.backButtonKey), findsOneWidget);
    expect(findTextWidget(tester, 'TSTitle').data, 'T1');
    expect(findTextWidget(tester, 'TSSubtitle').data, 'ST1');
    expect(find.text('TC11'), findsOneWidget);
    expect(find.text('TC12'), findsOneWidget);
    // Done Icon
    expect(find.byKey(const Key('DoneIcon0')), findsOneWidget);
    expect(find.byKey(const Key('DoneIcon1')), findsNothing);
    // Back to home and open teaching 2
    await tapByKey(tester, TeachingSummaryScreen.backButtonKey, 1);
    expect(find.byKey(const Key(Routes.teachingSummary)), findsNothing);
    // Continue teaching 2 goes to first chapter
    await tapByKey(tester, const Key('OpenTeaching2'));
    await tick(tester, 2);
    expect(findTextWidget(tester, 'TSTitle').data, 'T2');
    expect(findTextWidget(tester, 'TSSubtitle').data, 'ST2');
  });
}
