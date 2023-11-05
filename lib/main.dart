import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fv1/app.dart';
import 'package:fv1/providers/create.dart';
import 'package:fv1/services/api_client/api_client.dart';
import 'package:fv1/services/api_client/api_routes.dart';
import 'package:fv1/services/api_client/auth_service.dart';
import 'package:fv1/services/api_client/http_client.dart';
import 'package:fv1/services/audio_player/create.dart';
import 'package:fv1/services/config/config_service.dart';
import 'package:fv1/services/data/data_service.dart';
import 'package:fv1/services/datetime/datetime_service.dart';
import 'package:fv1/services/storage/native_storage_service.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import 'package:http/retry.dart';
import 'package:logging/logging.dart';

void main() async {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    if (kDebugMode) {
      print('${record.level.name}: ${record.time}: ${record.message}');
    }
  });
  GoRouter.optionURLReflectsImperativeAPIs = true;
  final config = ConfigService();
  final storage = NativeStorageService();
  await Future.wait([config.init(), storage.init()]);
  final apiRoutes = ApiRoutes(config.api);
  final baseHttpClient = RetryClient(Client());
  final httpClient = CustomHttpClient(baseHttpClient, null);
  final authService = AuthService(storage, apiRoutes, httpClient);
  final apiClient = ApiClient(
    authService,
    apiRoutes,
    HttpClientWithAuth(authService, baseHttpClient),
  );
  final dataService = createDataService(apiClient);
  final audioPlayer = createAudioPlayer();
  final dateTimeService = DateTimeService();
  final providers = createProviders(
    dataService,
    audioPlayer,
    dateTimeService,
    storage,
    authService,
  );
  runApp(Fv1App(providers));
}
