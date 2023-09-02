import 'package:flutter/widgets.dart';
import 'package:fv1/providers/app_state.dart';
import 'package:fv1/providers/browser_state.dart';
import 'package:fv1/providers/explorer_state.dart';
import 'package:fv1/services/data/data_service.dart';
import 'package:provider/provider.dart';

List<ChangeNotifierProvider<ChangeNotifier>> createProviders(
    AbstractDataService dataService) {
  return [
    ChangeNotifierProvider<AppState>(create: (_) => AppState()),
    ChangeNotifierProvider<ExplorerState>(
      create: (_) => ExplorerState(dataService),
    ),
    ChangeNotifierProvider<BrowserState>(
      create: (_) => BrowserState(dataService),
    ),
  ];
}
