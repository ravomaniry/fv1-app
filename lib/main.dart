import 'package:flutter/material.dart';
import 'package:fv1/app.dart';
import 'package:fv1/providers/create.dart';
import 'package:fv1/services/audio_player/create.dart';
import 'package:fv1/services/data/http_client.dart';
import 'package:fv1/services/data/native_data_service.dart';
import 'package:go_router/go_router.dart';

void main() {
  GoRouter.optionURLReflectsImperativeAPIs = true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final httpClient = AppHttpClient();
    final dataService = NativeDataService(httpClient);
    final audioPlayer = createAudioPlayer();
    final providers = createProviders(dataService, audioPlayer);
    return Fv1App(providers);
  }
}
