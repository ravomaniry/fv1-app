import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fv1/app.dart';
import 'package:fv1/models/texts.dart';
import 'package:fv1/models/user.dart';
import 'package:fv1/models/user_tokens.dart';
import 'package:fv1/providers/create.dart';
import 'package:fv1/services/api_client/api_routes.dart';
import 'package:fv1/services/api_client/auth_service.dart';
import 'package:fv1/services/storage/storage_service.dart';
import 'package:fv1/types/exceptions.dart';
import 'package:fv1/ui/screens/home.dart';
import 'package:fv1/ui/widgets/continue_button.dart';
import 'package:fv1/ui/widgets/form/password_field.dart';
import 'package:fv1/ui/widgets/form/username_field.dart';
import 'package:fv1/ui/widgets/login_error.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'api_client_test.mocks.dart';
import 'home_screen_test.mocks.dart';
import 'utils/jwt.dart';
import 'utils/mock_api_config.dart';
import 'utils/tick.dart';

void main() {
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

  testWidgets('Log in with username and password', (tester) async {
    await tester.pumpWidget(Fv1App(providers));
    await tick(tester, 1);
    // Render login form
    expect(find.byKey(UsernameFormField.fieldKey), findsOneWidget);
    // Validate form
    await tapByKey(tester, ContinueButton.buttonKey, 1);
    await enterText(tester, find.byKey(UsernameFormField.fieldKey), 'user1', 1);
    await tapByKey(tester, ContinueButton.buttonKey, 1);
    await enterText(tester, find.byKey(PasswordFormField.fieldKey), 'pass1', 1);
    verifyNever(baseClient.postJson(any, any));
    // No error message
    expect(find.byKey(LoginError.textKey), findsNothing);
    // Wrong credentials
    when(baseClient.postJson(routes.login, any)).thenAnswer((_) {
      throw InvalidCredentialException();
    });
    await tapByKey(tester, ContinueButton.buttonKey, 1);
    expect(
      textContent(tester, find.byKey(LoginError.textKey)),
      mgTexts.errorInvalidCredentials,
    );
    final call1 = verify(baseClient.postJson(routes.login, captureAny));
    call1.called(1);
    expect(call1.captured.first, {'username': 'user1', 'password': 'pass1'});
    // Success
    await enterText(tester, find.byKey(PasswordFormField.fieldKey), 'pass2', 1);
    final accessTk = createAccessToken(DateTime.now());
    when(baseClient.postJson(routes.login, any)).thenAnswer(
      (_) async => Response(
        jsonEncode({
          'user': {'username': 'user1', 'id': 1},
          'tokens': {'accessToken': accessTk, 'refreshToken': 'rt'},
        }),
        200,
      ),
    );
    await tapByKey(tester, ContinueButton.buttonKey, 1);
    final call2 = verify(baseClient.postJson(routes.login, captureAny));
    expect(call2.captured.first, {'username': 'user1', 'password': 'pass2'});
    // Render home screen once user is logged in
    verify(storageService.saveUser(UserModel(1, 'user1'))).called(1);
    verify(storageService.saveTokens(UserTokens('rt', accessTk))).called(1);
    expect(find.byKey(HomeScreen.explorerHelpKey), findsOneWidget);
  });

  testWidgets('Register with new account', (tester) async {
    await tester.pumpWidget(Fv1App(providers));
    await tick(tester, 1);
    await tapByText(tester, mgTexts.createAccount, 1);
    await enterText(tester, find.byKey(UsernameFormField.fieldKey), 'user1', 1);
    // Validation
    await tapByKey(tester, ContinueButton.buttonKey, 1);
    verifyNever(baseClient.postJson(any, any));
    // Username already exists
    when(baseClient.postJson(routes.register, any)).thenAnswer((_) {
      throw DuplicateUsernameException();
    });
    await enterText(tester, find.byKey(PasswordFormField.fieldKey), 'pass1', 1);
    await tapByKey(tester, ContinueButton.buttonKey, 1);
    expect(find.text(mgTexts.errorDuplicateUsername), findsOneWidget);
    // Success
    final accessTk = createAccessToken(DateTime.now());
    when(baseClient.postJson(routes.register, any)).thenAnswer(
      (_) async => Response(
        jsonEncode({
          'user': {'username': 'user1', 'id': 1},
          'tokens': {'accessToken': accessTk, 'refreshToken': 'rt'},
        }),
        200,
      ),
    );
    await tapByKey(tester, ContinueButton.buttonKey, 1);
    // Save data and go to home screen
    verify(storageService.saveUser(UserModel(1, 'user1'))).called(1);
    verify(storageService.saveTokens(UserTokens('rt', accessTk))).called(1);
    expect(find.byKey(HomeScreen.explorerHelpKey), findsOneWidget);
  });

  testWidgets('Register guest', (tester) async {
    await tester.pumpWidget(Fv1App(providers));
    await tick(tester, 1);
    final accessTk = createAccessToken(DateTime.now());
    when(baseClient.post(routes.registerGuest)).thenAnswer(
      (_) async => Response(
        jsonEncode({
          'user': {'username': 'user1', 'id': 1},
          'tokens': {'accessToken': accessTk, 'refreshToken': 'rt'},
        }),
        200,
      ),
    );
    await tapByText(tester, mgTexts.continueAsGuest, 1);
    // Save data and go to home screen
    verify(storageService.saveUser(UserModel(1, 'user1'))).called(1);
    verify(storageService.saveTokens(UserTokens('rt', accessTk))).called(1);
    expect(find.byKey(HomeScreen.explorerHelpKey), findsOneWidget);
  });
}
