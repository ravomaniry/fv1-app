import 'dart:convert';
import 'dart:io';

import 'package:fv1/services/api_client/auth_service.dart';
import 'package:fv1/types/exceptions.dart';
import 'package:http/http.dart';
import 'package:logging/logging.dart';

class CustomHttpClient extends BaseClient {
  final _logger = Logger('CustomHttpClient');
  final BaseClient _inner;
  final Future<Map<String, String>> Function()? _createHeaders;

  CustomHttpClient(this._inner, this._createHeaders);

  @override
  Future<StreamedResponse> send(BaseRequest request) async {
    _logger.info('${request.method} ${request.url}');
    if (_createHeaders != null) {
      await _addCustomHeaders(request.headers);
    }
    final resp = await _inner.send(request);
    if (resp.statusCode >= 400) {
      final body = await resp.stream.bytesToString();
      _convertResponseToException(resp.statusCode, body);
    }
    return resp;
  }

  Future<Response> postJson(Uri uri, Map<String, dynamic> body) async {
    _logger.info('POST $uri');
    return _handleErrorCodes(
      post(uri, body: jsonEncode(body), headers: await _jsonHeaders()),
    );
  }

  Future<Response> putJson(Uri uri, Map<String, dynamic> body) async {
    _logger.info('PUT $uri');
    return _handleErrorCodes(
      put(uri, body: jsonEncode(body), headers: await _jsonHeaders()),
    );
  }

  Future<Map<String, String>> _jsonHeaders() async {
    return _addCustomHeaders({'Content-Type': 'application/json'});
  }

  Future<Response> _handleErrorCodes(Future<Response> futureResponse) async {
    final resp = await futureResponse;
    if (resp.statusCode >= 400) {
      _convertResponseToException(resp.statusCode, resp.body);
    }
    return resp;
  }

  Future<Map<String, String>> _addCustomHeaders(
      Map<String, String> base) async {
    if (_createHeaders != null) {
      final extra = await _createHeaders!();
      extra.forEach((key, value) {
        base[key] = value;
      });
    }
    return base;
  }

  void _convertResponseToException(int code, String body) {
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
  HttpClientWithAuth(final AuthService authService, BaseClient inner)
      : super(
          inner,
          () async {
            final accessToken = await authService.getAccessToken();
            return {'Authorization': 'Bearer $accessToken'};
          },
        );
}
