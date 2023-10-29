import 'package:fv1/models/login_data.dart';
import 'package:fv1/models/login_response.dart';
import 'package:fv1/models/register_data.dart';
import 'package:fv1/models/user.dart';
import 'package:fv1/models/user_tokens.dart';
import 'package:fv1/services/api_client/api_routes.dart';
import 'package:fv1/services/api_client/http_client.dart';
import 'package:fv1/services/api_client/response_dtos.dart';
import 'package:fv1/services/storage/storage_service.dart';
import 'package:fv1/types/exceptions.dart';
import 'package:logging/logging.dart';

class AuthService {
  final StorageService _storage;
  final ApiRoutes _routes;
  final _logger = Logger('AuthService');
  final CustomHttpClient _client;
  UserTokens? _tokens;

  AuthService(this._storage, this._routes, this._client);

  Future<UserModel> login(LoginData data) {
    return _handleLogin(LoginDto().parse(_client.postJson(
      _routes.login,
      data.toJson(),
    )));
  }

  Future<UserModel> register(RegisterData data) async {
    return _handleLogin(LoginDto().parse(_client.postJson(
      _routes.register,
      data.toJson(),
    )));
  }

  Future<UserModel> registerGuest() async {
    return _handleLogin(LoginDto().parse(_client.post(_routes.registerGuest)));
  }

  void logOut() {
    _storage.deleteToken();
    _storage.deleteUser();
  }

  Future<UserModel> _handleLogin(Future<LoginResponseModel> future) async {
    final resp = await future;
    _saveTokens(resp.tokens);
    _storage.saveUser(resp.user);
    return resp.user;
  }

  Future<void> _refreshExpiredToken() async {
    if (_tokens!.isAccessTokenExpired) {
      final token = await RefreshTokenDto().parse(
        _client.postJson(
          _routes.refreshToken,
          {'token': _tokens!.refreshToken},
        ),
      );
      _tokens?.updateAccessToken(token);
      _logger.info('Access token refreshed');
      _saveTokens(_tokens!);
    }
  }

  _saveTokens(UserTokens tokens) {
    _tokens = tokens;
    _storage.saveTokens(tokens);
    _logger.info('Tokens saved');
  }

  Future<String> getAccessToken() async {
    _tokens ??= await _storage.getTokens();
    _logger.info('Token from local storage: ${_tokens != null}');
    if (_tokens == null) {
      throw NotConnectedException();
    }
    await _refreshExpiredToken();
    return _tokens!.accessToken;
  }
}
