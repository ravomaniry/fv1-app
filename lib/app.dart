import 'package:flutter/material.dart';
import 'package:fv1/ui/routes.dart';
import 'package:provider/provider.dart';

class Fv1App extends StatefulWidget {
  final List<ChangeNotifierProvider<ChangeNotifier>> _providers;

  const Fv1App(this._providers, {super.key});

  @override
  State<Fv1App> createState() => _Fv1AppState();
}

class _Fv1AppState extends State<Fv1App> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: widget._providers,
      child: const CreateRouter(),
    );
  }
}
