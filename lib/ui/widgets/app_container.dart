import 'package:flutter/material.dart';
import 'package:fv1/providers/app_state.dart';
import 'package:fv1/providers/browser_state.dart';
import 'package:fv1/ui/widgets/app_bar.dart';
import 'package:fv1/ui/widgets/error.dart';
import 'package:fv1/ui/widgets/responsive_padding.dart';
import 'package:provider/provider.dart';

class AppContainer extends StatelessWidget {
  final Widget body;
  final bool backButton;
  final Key? backButtonKey;
  final Widget? floatingActionButton;

  const AppContainer({
    super.key,
    required this.body,
    this.floatingActionButton,
    required this.backButton,
    this.backButtonKey,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer2<AppState, BrowserState>(
      builder: (_, appState, browserState, __) => _Body(
        appState: appState,
        browserState: browserState,
        body: body,
        floatingActionButton: floatingActionButton,
        backButton: backButton,
        backButtonKey: backButtonKey,
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final AppState appState;
  final BrowserState browserState;
  final Widget body;
  final bool backButton;
  final Key? backButtonKey;
  final Widget? floatingActionButton;

  const _Body({
    required this.appState,
    required this.browserState,
    required this.body,
    required this.floatingActionButton,
    required this.backButton,
    required this.backButtonKey,
  });

  Widget? _buildBottomSheet() {
    return browserState.error == null
        ? null
        : AppErrorWidget(appState: appState, browserState: browserState);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, backButton, backButtonKey),
      floatingActionButton: floatingActionButton,
      bottomSheet: _buildBottomSheet(),
      body: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: ResponsivePadding(child: body),
      ),
    );
  }
}
