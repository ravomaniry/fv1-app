import 'package:fv1/models/user_tokens.dart';
import 'package:fv1/services/api_client/api_routes.dart';
import 'package:fv1/services/api_client/utils.dart';
import 'package:fv1/services/storage/storage_service.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:logging/logging.dart';

class _AuthClient extends http.BaseClient {
  final _logger = Logger('_AuthClient');
  final _inner = RetryClient(http.Client());

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    _logger.info('${request.method} ${request.url}');
    return _inner.send(request);
  }
}

class AuthService {
  final StorageService _storage;
  final ApiRoutes _routes;
  final _logger = Logger('AuthService');
  final _client = _AuthClient();
  UserTokens? _tokens;

  AuthService(this._storage, this._routes);

  Future<void> _register() async {
    final resp = await parseJsonResponse(_client.post(_routes.registerGuest),
        (d) => _LoginResponseDto.fromJson(d));
    _updateToken(resp.tokens);
    _logger.info('Registered as guest user');
  }

  Future<void> _refreshExpiredToken() async {
    const buffer = 120; // 2 minutes
    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    if (_tokens!.expirationOn <= now - buffer) {
      try {
        final token = await parseJsonResponse(
          _client.post(
            _routes.refreshToken,
            body: {'token': _tokens!.refreshToken},
          ),
          (d) => d['token'] as String,
        );
        _tokens?.updateAccessToken(token);
        _logger.info('Access token refreshed ${_tokens?.expirationOn}');
        _updateToken(_tokens!);
      } catch (e) {
        _logger.shout('Failed to refresh token $e');
        // Register the user with a new guest account if token refresh fails
        // Check response status code
        _tokens = null;
        await _register();
      }
    }
  }

  _updateToken(UserTokens tokens) {
    _tokens = tokens;
    _storage.saveTokens(tokens);
    _logger.info('Tokens saved');
  }

  Future<String> getAccessToken() async {
    _tokens ??= await _storage.getTokens();
    _logger.info('Token from local storage: ${_tokens != null}');
    if (_tokens == null) {
      await _register();
    }
    await _refreshExpiredToken();
    return _tokens!.accessToken;
  }
}

class _LoginResponseDto {
  final UserTokens tokens;

  _LoginResponseDto(this.tokens);

  factory _LoginResponseDto.fromJson(Map<String, dynamic> json) {
    return _LoginResponseDto(UserTokens.fromJson(json['tokens']));
  }
}
