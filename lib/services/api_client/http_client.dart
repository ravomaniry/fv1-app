import 'dart:convert';
import 'dart:io';

import 'package:fv1/services/api_client/auth_service.dart';
import 'package:fv1/types/exceptions.dart';
import 'package:http/http.dart';
import 'package:logging/logging.dart';

class CustomHttpClient extends BaseClient {
  final BaseClient _inner;

  CustomHttpClient(this._inner);

  @override
  Future<StreamedResponse> send(BaseRequest request) async {
    final resp = await _inner.send(request);
    if (resp.statusCode >= 400) {
      final body = await resp.stream.bytesToString();
      _convertResponseToException(resp.statusCode, body);
    }
    return resp;
  }

  Future<Response> postJson(Uri uri, Map<String, dynamic> body) async {
    return _handleErrorCodes(
      post(uri, body: jsonEncode(body), headers: _jsonHeader()),
    );
  }

  Future<Response> putJson(Uri uri, Map<String, dynamic> body) {
    return _handleErrorCodes(
      put(uri, body: jsonEncode(body), headers: _jsonHeader()),
    );
  }

  Map<String, String> _jsonHeader() {
    return {'Content-Type': 'application/json'};
  }

  Future<Response> _handleErrorCodes(Future<Response> futureResponse) async {
    final resp = await futureResponse;
    if (resp.statusCode >= 400) {
      _convertResponseToException(resp.statusCode, resp.body);
    }
    return resp;
  }

  _convertResponseToException(int code, String body) {
    final data = jsonDecode(body);
    switch (data['code']) {
      case 'invalidCredentials':
        throw InvalidCredentialException();
      case 'userExists':
        throw DuplicateUsernameException();
      case 'weakPassword':
        throw WeakPasswordException();
      default:
        throw HttpException('Request failed with status $code');
    }
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
