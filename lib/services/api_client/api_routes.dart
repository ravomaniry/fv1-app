import 'package:fv1/services/config/api_config.dart';

Uri _createUri(ApiConfig config, String endpoint) {
  return config.scheme == HttpScheme.http
      ? Uri.http(config.apiUrl, endpoint)
      : Uri.https(config.apiUrl, endpoint);
}

class ApiRoutes {
  final ApiConfig _config;
  final Uri registerGuest;
  final Uri refreshToken;
  final Uri progress;
  final Uri startTeaching;
  final Uri teachingNew;

  ApiRoutes(this._config)
      : registerGuest = _createUri(_config, 'api/auth/register-guest'),
        refreshToken = _createUri(_config, 'api/auth/refresh-token'),
        progress = _createUri(_config, 'api/progress'),
        startTeaching = _createUri(_config, 'api/progress/start'),
        teachingNew = _createUri(_config, 'api/teaching/new');

  Uri audioUrl(String id) {
    return _createUri(_config, 'api/audio/url/$id');
  }
}
