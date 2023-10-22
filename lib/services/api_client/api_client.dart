import 'dart:convert';

import 'package:fv1/models/progress.dart';
import 'package:fv1/models/teaching_summary.dart';
import 'package:fv1/services/api_client/api_routes.dart';
import 'package:fv1/services/api_client/auth_service.dart';
import 'package:fv1/services/api_client/dtos.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';

class _ClientWithAuth extends http.BaseClient {
  final AuthService _authService;
  final _logger = Logger('_ClientWithAuth');
  final http.BaseClient _baseClient;

  _ClientWithAuth(this._authService, this._baseClient);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    _logger.info('${request.method} ${request.url}');
    final accessToken = await _authService.getAccessToken();
    request.headers['Authorization'] = 'Bearer $accessToken';
    return _baseClient.send(request);
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

  ApiClient(AuthService authService, this._routes, http.BaseClient baseClient)
      : _client = _ClientWithAuth(authService, baseClient);

  Future<List<ProgressModel>> getProgresses() async {
    return await GetProgressDto().parse(_client.get(_routes.progress));
  }

  Future<ProgressModel> startTeaching(int id) async {
    return await StartTeachingDto()
        .parse(_client.postJson(_routes.startTeaching, {'teachingId': id}));
  }

  Future<String> getAudioUrl(String id) async {
    return await GetAudioUrlDto().parse(_client.get(_routes.audioUrl(id)));
  }

  Future<List<TeachingSummaryModel>> loadNewTeachings() async {
    return await GetNewTeachingsDto().parse(_client.get(_routes.teachingNew));
  }
}
