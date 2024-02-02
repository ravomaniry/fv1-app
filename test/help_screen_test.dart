import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fv1/app.dart';
import 'package:fv1/providers/create.dart';
import 'package:fv1/services/api_client/api_routes.dart';
import 'package:fv1/services/api_client/auth_service.dart';
import 'package:fv1/services/storage/storage_service.dart';
import 'package:fv1/ui/screens/help.dart';
import 'package:fv1/ui/widgets/continue_button.dart';
import 'package:fv1/ui/widgets/form/username_field.dart';
import 'package:fv1/ui/widgets/help_button.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'api_client_test.mocks.dart';
import 'home_screen_test.mocks.dart';
import 'utils/mock_api_config.dart';
import 'utils/tick.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late List<ChangeNotifierProvider<ChangeNotifier>> providers;
  late StorageService storageService;
  late MockCustomHttpClient baseClient;
  final routes = ApiRoutes(MockApiConfig());

  setUp(() {
    final dataService = MockAbstractDataService();
    when(dataService.sync()).thenAnswer(
      (_) => Future.delayed(const Duration(seconds: 1)),
    );
    when(dataService.loadProgresses()).thenAnswer((_) async => []);
    storageService = MockStorageService();
    baseClient = MockCustomHttpClient();
    providers = createProviders(
      dataService,
      MockAppAudioPlayer(),
      MockDateTimeService(),
      storageService,
      AuthService(storageService, routes, baseClient),
    );
  });

  testWidgets('Goes to help screen when user clicks on help button',
      (tester) async {
    await tester.pumpWidget(Fv1App(providers));
    await tick(tester, 1);
    await tapByKey(tester, HelpButton.buttonKey, 1);
    expect(find.byKey(HelpScreen.widgetKey), findsOneWidget);
    // It goes to home screen and then redirected to the auth screen
    await tapByKey(tester, ContinueButton.buttonKey, 1);
    expect(find.byKey(UsernameFormField.fieldKey), findsOneWidget);
  });
}
