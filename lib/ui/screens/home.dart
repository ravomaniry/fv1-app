import 'package:flutter/material.dart';
import 'package:fv1/models/progress.dart';
import 'package:fv1/providers/app_state.dart';
import 'package:fv1/providers/browser_state.dart';
import 'package:fv1/ui/routes.dart';
import 'package:fv1/ui/screens/app_bar_menu.dart';
import 'package:fv1/ui/screens/teaching_summary.dart';
import 'package:fv1/ui/widgets/h2.dart';
import 'package:fv1/ui/widgets/home_card.dart';
import 'package:fv1/ui/widgets/home_page_container.dart';
import 'package:fv1/ui/widgets/loader.dart';
import 'package:fv1/ui/widgets/no_data_message.dart';
import 'package:fv1/ui/widgets/search_button.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const syncLoaderKey = Key('syncLoader');
  static const explorerHelpKey = Key('explorerHelp');
  static const searchButtonKey = Key('searchButton');

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<BrowserState>().onHomeScreenMounted();
  }

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
    context.goNamed(Routes.explorer);
  }

  Widget _buildProgress(BuildContext context, ProgressModel progress) {
    return HomeCard(
      onTap: () => context.goNamed(
        Routes.teachingSummary,
        pathParameters: {
          TeachingSummaryScreen.teachingIdKey: progress.teaching.id.toString(),
        },
      ),
      title: Text(
        progress.teaching.title,
        key: Key('HomeTeachingTitle${progress.teaching.id}'),
      ),
      subtitle: Column(
        children: [
          Text(
            progress.teaching.subtitle,
            key: Key('HomeTeachingSubtitle${progress.teaching.id}'),
          ),
          LinearProgressIndicator(
            value: progress.completionPercentage,
            key: Key('HomeScreenProgress${progress.teaching.id}'),
          ),
        ],
      ),
      trailing: Icon(
        key: Key('OpenTeaching${progress.teaching.id}'),
        Icons.chevron_right,
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget _buildEmptyScreen() {
    return NoDataMessage(
      _appState.texts.explorerHelp,
      key: HomeScreen.explorerHelpKey,
    );
  }

  Widget _buildRegularScreen(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_browserState.localProgresses?.isNotEmpty == true)
            ScreenH2(_appState.texts.teachingsInProgress),
          for (final progress in _browserState.localProgresses ?? [])
            _buildProgress(context, progress),
          if (_browserState.teachingsList?.isNotEmpty == true)
            ScreenH2(_appState.texts.teachingsAvailable),
          for (final teaching in _browserState.teachingsList ?? [])
            Text(teaching.title),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isReady = _browserState.localProgresses != null;
    return HomePageContainer(
      texts: _appState.texts,
      appBarActions: const [AppBarActionButton()],
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
