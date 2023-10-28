import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fv1/services/config/api_config.dart';

class ConfigService {
  late ApiConfig api;

  Future<void> init() async {
    await dotenv.load(fileName: '.env');
    api = ApiConfig(dotenv.env);
  }
}
