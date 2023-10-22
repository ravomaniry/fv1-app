import 'dart:convert';

import 'package:fv1/models/progress.dart';
import 'package:fv1/models/teaching_summary.dart';
import 'package:fv1/services/api_client/api_routes.dart';
import 'package:fv1/services/api_client/auth_service.dart';
import 'package:fv1/services/api_client/utils.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:logging/logging.dart';

class _ClientWithAuth extends http.BaseClient {
  final AuthService _authService;
  final _logger = Logger('_ClientWithAuth');
  final _inner = RetryClient(http.Client());

  _ClientWithAuth(this._authService);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    _logger.info('${request.method} ${request.url}');
    final accessToken = await _authService.getAccessToken();
    request.headers['Authorization'] = 'Bearer $accessToken';
    return _inner.send(request);
  }

  Future<http.Response> postJson(Uri uri, Map<String, dynamic> body) {
    return post(
      uri,
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );
  }
}

class ApiClient {
  final _ClientWithAuth _client;
  final ApiRoutes _routes;

  ApiClient(AuthService authService, this._routes)
      : _client = _ClientWithAuth(authService);

  Future<List<ProgressModel>> getProgresses() async {
    return await parseJsonListResponse(
      _client.get(_routes.progress),
      (d) => ProgressModel.fromJson(d),
    );
  }

  Future<ProgressModel> startTeaching(int id) async {
    return await parseJsonResponse(
      _client.postJson(_routes.startTeaching, {'teachingId': id}),
      (d) => ProgressModel.fromJson(d),
    );
  }

  Future<String> getAudioUrl(String id) async {
    return await parseJsonResponse(
      _client.get(_routes.audioUrl(id)),
      (d) => d['url'] as String,
    );
  }

  Future<List<TeachingSummaryModel>> loadNewTeachings() async {
    return await parseJsonListResponse(
      _client.get(_routes.teachingNew),
      (d) => TeachingSummaryModel.fromJson(d),
    );
  }
}
