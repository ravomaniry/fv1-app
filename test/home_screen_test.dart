import 'package:flutter_test/flutter_test.dart';
import 'package:fv1/app.dart';
import 'package:fv1/providers/create.dart';
import 'package:fv1/services/data/data_service.dart';
import 'package:fv1/ui/screens/home.dart';
import 'package:fv1/ui/widgets/loader.dart';
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
      when(dataService.sync()).thenAnswer(
        (_) => Future.delayed(const Duration(seconds: 1)),
      );
      when(dataService.loadProgresses()).thenAnswer((_) async => []);
      final providers = createProviders(dataService);
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
}
