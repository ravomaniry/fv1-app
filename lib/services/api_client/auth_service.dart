import 'package:fv1/models/user_tokens.dart';
import 'package:fv1/services/api_client/api_routes.dart';
import 'package:fv1/services/api_client/response_dtos.dart';
import 'package:fv1/services/storage/storage_service.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';

class _AuthClient extends http.BaseClient {
  final _logger = Logger('_AuthClient');
  final http.BaseClient _inner;

  _AuthClient(this._inner);

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
  final _AuthClient _client;
  UserTokens? _tokens;

  AuthService(this._storage, this._routes, http.BaseClient baseClient)
      : _client = _AuthClient(baseClient);

  Future<void> _register() async {
    final tokens = await LoginDto().parse(_client.post(_routes.registerGuest));
    _updateToken(tokens);
    _logger.info('Registered as guest user');
  }

  Future<void> _refreshExpiredToken() async {
    if (_tokens!.isAccessTokenExpired) {
      try {
        final token = await RefreshTokenDto().parse(
          _client.post(
            _routes.refreshToken,
            body: {'token': _tokens!.refreshToken},
          ),
        );
        _tokens?.updateAccessToken(token);
        _logger.info('Access token refreshed');
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
