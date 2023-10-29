import 'dart:convert';
import 'dart:io';

import 'package:fv1/services/api_client/auth_service.dart';
import 'package:http/http.dart';
import 'package:logging/logging.dart';

class CustomHttpClient extends BaseClient {
  final BaseClient _inner;

  CustomHttpClient(this._inner);

  @override
  Future<StreamedResponse> send(BaseRequest request) async {
    final resp = await _inner.send(request);
    if (resp.statusCode >= 400) {
      final msg = await resp.stream.bytesToString();
      throw HttpException('Status ${resp.statusCode}; details: $msg');
    }
    return resp;
  }

  Future<Response> postJson(Uri uri, Map<String, dynamic> body) {
    return post(uri, body: jsonEncode(body), headers: _jsonHeader());
  }

  Future<Response> putJson(Uri uri, Map<String, dynamic> body) {
    return put(uri, body: jsonEncode(body), headers: _jsonHeader());
  }

  Map<String, String> _jsonHeader() {
    return {'Content-Type': 'application/json'};
  }
}

class HttpClientWithAuth extends CustomHttpClient {
  final AuthService _authService;
  final _logger = Logger('_ClientWithAuth');

  HttpClientWithAuth(this._authService, BaseClient inner) : super(inner);

  @override
  Future<StreamedResponse> send(BaseRequest request) async {
    _logger.info('${request.method} ${request.url}');
    final accessToken = await _authService.getAccessToken();
    request.headers['Authorization'] = 'Bearer $accessToken';
    return super.send(request);
  }
}

class AuthServiceHttpClient extends CustomHttpClient {
  final _logger = Logger('AuthClient');

  AuthServiceHttpClient(super.inner);

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    _logger.info('${request.method} ${request.url}');
    return super.send(request);
  }
}
