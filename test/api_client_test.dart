import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:fv1/models/chapter.dart';
import 'package:fv1/models/chapter_score.dart';
import 'package:fv1/models/progress.dart';
import 'package:fv1/models/quiz_question.dart';
import 'package:fv1/models/section.dart';
import 'package:fv1/models/teaching.dart';
import 'package:fv1/models/user_tokens.dart';
import 'package:fv1/services/api_client/api_client.dart';
import 'package:fv1/services/api_client/api_routes.dart';
import 'package:fv1/services/api_client/auth_service.dart';
import 'package:fv1/services/config/api_config.dart';
import 'package:fv1/services/storage/storage_service.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([
  MockSpec<http.BaseClient>(),
  MockSpec<StorageService>(),
  MockSpec<ApiConfig>(),
])
import 'api_client_test.mocks.dart';

http.StreamedResponse _createStreamedResponse(http.Response response) {
  final streamCtr = StreamController<List<int>>();
  streamCtr.add(response.bodyBytes.toList());
  streamCtr.close();
  return http.StreamedResponse(streamCtr.stream, response.statusCode);
}

String? _getAuthHeader(http.BaseRequest request) {
  return request.headers['Authorization'];
}

String _getReqPath(http.BaseRequest request) {
  return request.url.path;
}

String _createAccessToken(DateTime expireOn) {
  return 'header.${base64.encode(utf8.encode(jsonEncode({
        'exp': expireOn.millisecondsSinceEpoch ~/ 1000
      })))}.footer';
}

void main() {
  const oneHour = Duration(hours: 1);
  UserTokens? cachedTokens;
  late StorageService storage;
  late ApiRoutes routes;
  late MockBaseClient authBaseClient;
  late MockBaseClient apiBaseClient;
  late ApiClient apiClient;
  http.Response? authResponse;

  setUp(() {
    authBaseClient = MockBaseClient();
    apiBaseClient = MockBaseClient();
    when(authBaseClient.send(any)).thenAnswer(
      (_) async => _createStreamedResponse(authResponse!),
    );
    when(apiBaseClient.send(any)).thenAnswer(
      (_) async => _createStreamedResponse(http.Response('[]', 200)),
    );
    final config = MockApiConfig();
    when(config.scheme).thenReturn(HttpScheme.http);
    when(config.apiUrl).thenReturn('10.0.2.2:3000');
    storage = MockStorageService();
    when(storage.getTokens()).thenAnswer((_) async => cachedTokens);
    routes = ApiRoutes(config);
    final authService = AuthService(storage, routes, authBaseClient);
    apiClient = ApiClient(authService, routes, apiBaseClient);
  });

  test('Refresh token and set headers', () async {
    // Register when token is null
    cachedTokens = null;
    final accessToken = _createAccessToken(DateTime.now().add(oneHour));
    final tokens = UserTokens('rt', accessToken);
    authResponse = http.Response(jsonEncode({'tokens': tokens}), 200);
    final progresses = await apiClient.getProgresses();
    expect(progresses, []);
    // Register
    final authReq = verify(authBaseClient.send(captureAny));
    expect(authReq.callCount, 1);
    expect(_getReqPath(authReq.captured.single), routes.registerGuest.path);
    // Call get progress with access token
    final getProgressReq = verify(apiBaseClient.send(captureAny));
    expect(_getReqPath(getProgressReq.captured.single), routes.progress.path);
    expect(
      _getAuthHeader(getProgressReq.captured.single),
      'Bearer $accessToken',
    );
    // Attempt to get cached token and store the token locally
    verify(storage.getTokens()).called(1);
    verify(storage.saveTokens(tokens)).called(1);
    // Subsequent calls does not ask for token refresh
    await apiClient.getProgresses();
    verifyNoMoreInteractions(authBaseClient);
    verifyNoMoreInteractions(storage);
    final call2 = verify(apiBaseClient.send(captureAny));
    expect(call2.callCount, 1);
    expect(_getAuthHeader(call2.captured.single), 'Bearer $accessToken');
  });

  test('Cached token is still valid', () async {
    final accessTk = _createAccessToken(
      DateTime.now().add(const Duration(seconds: 1)),
    );
    cachedTokens = UserTokens('rt', accessTk);
    await apiClient.getProgresses();
    verifyZeroInteractions(authBaseClient);
    expect(
      _getAuthHeader(verify(apiBaseClient.send(captureAny)).captured.single),
      'Bearer $accessTk',
    );
  });

  test('Cached token is expired', () async {
    final accessTk = _createAccessToken(
      DateTime.now().subtract(const Duration(seconds: 1)),
    );
    cachedTokens = UserTokens('rt', accessTk);
    final newAccessTk = _createAccessToken(DateTime.now().add(oneHour));
    authResponse = http.Response(jsonEncode({'token': newAccessTk}), 200);
    await apiClient.loadNewTeachings();
    // Refresh access token and store it locally
    final call1 = verify(apiBaseClient.send(captureAny));
    expect(call1.callCount, 1);
    expect(_getAuthHeader(call1.captured.single), 'Bearer $newAccessTk');
    verify(storage.saveTokens(UserTokens('rt', newAccessTk)));
    // Subsequent request
    await apiClient.loadNewTeachings();
    final call2 = verify(apiBaseClient.send(captureAny));
    verifyNoMoreInteractions(apiBaseClient);
    expect(_getAuthHeader(call2.captured.single), 'Bearer $newAccessTk');
  });

  test('Parse progress and teaching', () async {
    final file = File('test_resources/progresses.json').readAsStringSync();
    final accessTk = _createAccessToken(
      DateTime.now().add(const Duration(seconds: 1)),
    );
    cachedTokens = UserTokens('rt', accessTk);
    when(apiBaseClient.send(any)).thenAnswer(
      (_) async => _createStreamedResponse(http.Response(file, 200)),
    );
    final progresses = await apiClient.getProgresses();
    expect(progresses, [
      ProgressModel(
        id: 1,
        scores: [ChapterScore(correctAnswersPercentage: 0.5)],
        clientTimestamp: 0,
        teaching: TeachingModel(
          1,
          'T1',
          'ST1',
          [
            ChapterModel(
              'C1',
              [
                SectionModel('Efesiana 1:4-6', 'Content 1', '1.mp3'),
                SectionModel('Efesiana 2:10', 'Content 2', '2.mp3'),
              ],
              [
                QuizQuestionModel(
                  '1',
                  'Question 1',
                  ['Option 1', 'Option 2'],
                  'Response 1',
                ),
                QuizQuestionModel(
                  '2',
                  'Question 2',
                  ['Option 3', 'Option 4'],
                  'Response 2',
                ),
              ],
            ),
          ],
        ),
      )
    ]);
  });
}
