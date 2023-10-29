import 'package:fv1/services/config/api_config.dart';

class MockApiConfig implements ApiConfig {
  @override
  String get apiUrl => '10.0.0.2';

  @override
  HttpScheme get scheme => HttpScheme.http;
}
