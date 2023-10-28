import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fv1/app.dart';
import 'package:fv1/models/chapter.dart';
import 'package:fv1/models/progress.dart';
import 'package:fv1/models/teaching.dart';
import 'package:fv1/models/teaching_summary.dart';
import 'package:fv1/providers/create.dart';
import 'package:fv1/ui/screens/explorer.dart';
import 'package:fv1/ui/screens/home.dart';
import 'package:fv1/ui/screens/teaching_summary.dart';
import 'package:fv1/ui/widgets/loader.dart';
import 'package:fv1/ui/widgets/no_data_message.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'home_screen_test.mocks.dart';
import 'utils/tick.dart';

void main() {
  List<TeachingSummaryModel> teachings = [];
  List<ChangeNotifierProvider<ChangeNotifier>> providers = [];
  late MockAbstractDataService dataService;

  setUp(() {
    dataService = MockAbstractDataService();
    when(dataService.loadProgresses()).thenAnswer((_) async => []);
    when(dataService.loadNewTeachings()).thenAnswer((_) async => teachings);
    when(dataService.sync()).thenAnswer((_) async {});
    providers = createProviders(
      dataService,
      MockAppAudioPlayer(),
      MockDateTimeService(),
    );
  });

  testWidgets('No new teaching', (tester) async {
    teachings = [];
    await tester.pumpWidget(Fv1App(providers));
    await tick(tester, 1);
    await tapByKey(tester, HomeScreen.searchButtonKey, 1);
    expect(find.byKey(NoDataMessage.widgetKey), findsOneWidget);
  });

  testWidgets('Go to explorer screen and download metadata', (tester) async {
    teachings = [
      TeachingSummaryModel(1, 'T1', 'ST1'),
      TeachingSummaryModel(2, 'T2', 'ST2'),
    ];
    await tester.pumpWidget(Fv1App(providers));
    await tick(tester, 1);
    await tick(tester, 2);
    // Go to explorer screen
    await tapByKey(tester, HomeScreen.searchButtonKey);
    expect(find.byKey(ExplorerScreen.backButtonKey), findsOneWidget);
    expect(find.text('T1'), findsOneWidget);
    expect(find.text('ST1'), findsOneWidget);
    expect(find.text('T2'), findsOneWidget);
    expect(find.text('ST2'), findsOneWidget);
    // Open a teaching:
    // - Go to teaching screen
    // - Display dialog until teaching is loaded
    // - Display summary when loading is done
    when(dataService.startTeaching(1)).thenAnswer((_) async {
      await Future.delayed(const Duration(seconds: 1));
      return ProgressModel(
        id: 10,
        clientTimestamp: 1000,
        teaching: TeachingModel(1, 'T1', 'ST1', [ChapterModel('CH1', [], [])]),
        scores: [],
      );
    });
    await tapByText(tester, 'T1');
    await tick(tester);
    expect(find.text('T1'), findsNothing);
    expect(find.byKey(WrapInLoader.loaderKey), findsOneWidget);
    await tick(tester, 2);
    await tick(tester, 2);
    expect(find.byKey(const Key(TeachingSummaryScreen.route)), findsOneWidget);
    expect(find.text('ST1'), findsOneWidget);
    expect(find.text('CH1'), findsOneWidget);
  });
}
