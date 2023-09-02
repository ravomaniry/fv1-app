import 'package:flutter_test/flutter_test.dart';
import 'package:fv1/app.dart';
import 'package:fv1/models/progress.dart';
import 'package:fv1/providers/create.dart';
import 'package:fv1/services/data/data_service.dart';
import 'package:fv1/ui/screens/home.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<AbstractDataService>()])
import 'home_screen_test.mocks.dart';
import 'utils/tick.dart';

void main() {
  testWidgets(
    'No saved progress: Display button to go to explorer',
    (tester) async {
      final dataService = MockAbstractDataService();
      when(dataService.loadProgresses()).thenAnswer(
        (_) async => <ProgressModel>[],
      );
      final providers = createProviders(dataService);
      await tester.pumpWidget(Fv1App(providers));
      await tick(tester, 1);
      expect(find.byKey(HomeScreen.explorerHelpKey), findsOneWidget);
      expect(find.byKey(HomeScreen.searchButtonKey), findsOneWidget);
    },
  );
}
