import 'package:flutter/material.dart';
import 'package:fv1/app.dart';
import 'package:fv1/providers/app_state.dart';
import 'package:fv1/providers/browser_state.dart';
import 'package:fv1/providers/explorer_state.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final providers = [
      ChangeNotifierProvider<AppState>(create: (_) => AppState()),
      ChangeNotifierProvider<ExplorerState>(create: (_) => ExplorerState()),
      ChangeNotifierProvider<BrowserState>(create: (_) => BrowserState()),
    ];
    return Fv1App(providers);
  }
}
