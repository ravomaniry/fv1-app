import 'package:flutter/widgets.dart';
import 'package:fv1/providers/app_state.dart';
import 'package:fv1/providers/browser_state.dart';
import 'package:fv1/services/audio_player/audio_player.dart';
import 'package:fv1/services/data/data_service.dart';
import 'package:fv1/services/datetime/datetime_service.dart';
import 'package:provider/provider.dart';

List<ChangeNotifierProvider<ChangeNotifier>> createProviders(
  AbstractDataService dataService,
  AppAudioPlayer audioPlayer,
  DateTimeService dateTimeService,
) {
  return [
    ChangeNotifierProvider<AppState>(create: (_) => AppState()),
    ChangeNotifierProvider<BrowserState>(
      create: (_) => BrowserState(dataService, audioPlayer, dateTimeService),
    ),
  ];
}
