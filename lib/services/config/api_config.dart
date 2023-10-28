import 'package:flutter_dotenv/flutter_dotenv.dart';

enum HttpScheme { http, https }

class ApiConfig {
  final String apiUrl;
  final HttpScheme scheme;

  ApiConfig(Map<String, String> env)
      : apiUrl = dotenv.env['API_URL']!,
        scheme = dotenv.env['HTTP_SCHEME'] == 'https'
            ? HttpScheme.https
            : HttpScheme.http;
}
