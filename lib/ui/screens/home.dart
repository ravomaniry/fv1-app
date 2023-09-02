import 'package:flutter/material.dart';
import 'package:fv1/models/progress.dart';
import 'package:fv1/models/teaching.dart';
import 'package:fv1/providers/app_state.dart';
import 'package:fv1/providers/browser_state.dart';
import 'package:fv1/ui/screens/explorer.dart';
import 'package:fv1/ui/screens/teaching_summary.dart';
import 'package:fv1/ui/widgets/action_button.dart';
import 'package:fv1/ui/widgets/app_container.dart';
import 'package:fv1/ui/widgets/home_card.dart';
import 'package:fv1/ui/widgets/loader.dart';
import 'package:fv1/ui/widgets/search_button.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static const syncLoaderKey = Key('syncLoader');
  static const explorerHelpKey = Key('explorerHelp');
  static const searchButtonKey = Key('searchButton');

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<AppState, BrowserState>(
      builder: (_, appState, browserState, __) => _Body(appState, browserState),
    );
  }
}

class _Body extends StatelessWidget {
  final AppState _appState;
  final BrowserState _browserState;

  const _Body(this._appState, this._browserState);

  void _goToExplorer(BuildContext context) {
    context.goNamed(ExplorerScreen.route);
  }

  Widget _buildActionButton(BuildContext context, TeachingModel teaching) {
    return ActionButton(
      label: _appState.texts.continueButton,
      icon: Icons.chevron_right,
      buttonKey: Key('OpenTeaching${teaching.id}'),
      onPressed: () => context.goNamed(
        TeachingSummaryScreen.route,
        pathParameters: {
          TeachingSummaryScreen.teachingIdKey: teaching.id.toString(),
        },
      ),
    );
  }

  Widget _buildProgress(BuildContext context, ProgressModel progress) {
    return HomeCard(
      title: progress.teaching.title,
      subtitle: Column(
        children: [
          Text(progress.teaching.subtitle),
          LinearProgressIndicator(
            value: progress.completionPercentage,
            key: Key('HomeScreenProgress${progress.teaching.id}'),
          ),
        ],
      ),
      actionButton: _buildActionButton(context, progress.teaching),
    );
  }

  Widget _buildEmptyScreen() {
    return Center(
      child: Text(
        _appState.texts.explorerHelp,
        key: HomeScreen.explorerHelpKey,
      ),
    );
  }

  Widget _buildRegularScreen(BuildContext context) {
    return Column(
      children: [
        for (final progress in _browserState.localProgresses!)
          _buildProgress(context, progress),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isReady = _browserState.localProgresses != null;
    return AppContainer(
      backButton: false,
      floatingActionButton: isReady
          ? SearchButton(
              key: HomeScreen.searchButtonKey,
              onPressed: () => _goToExplorer(context),
            )
          : null,
      body: WrapInLoader(
        isReady: isReady,
        builder: () => _browserState.localProgresses!.isEmpty
            ? _buildEmptyScreen()
            : _buildRegularScreen(context),
      ),
    );
  }
}
