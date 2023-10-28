import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fv1/models/progress.dart';
import 'package:fv1/providers/app_state.dart';
import 'package:fv1/providers/browser_state.dart';
import 'package:fv1/ui/screens/explorer.dart';
import 'package:fv1/ui/screens/teaching_summary.dart';
import 'package:fv1/ui/widgets/home_card.dart';
import 'package:fv1/ui/widgets/loader.dart';
import 'package:fv1/ui/widgets/no_data_message.dart';
import 'package:fv1/ui/widgets/responsive_padding.dart';
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

  Widget _buildProgress(BuildContext context, ProgressModel progress) {
    return HomeCard(
      onTap: () => context.goNamed(
        TeachingSummaryScreen.route,
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
    return _HomePageContainer(
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

class _HomePageContainer extends StatelessWidget {
  final Widget body;
  final Widget? floatingActionButton;

  const _HomePageContainer({
    required this.body,
    required this.floatingActionButton,
  });

  double _calcColorBoxHeight(Size size) {
    return size.height * 0.4;
  }

  Widget _buildColoredContainer(Size size, ThemeData theme) {
    return Container(
      height: _calcColorBoxHeight(size),
      width: size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [theme.primaryColor, theme.primaryColorDark],
        ),
      ),
    );
  }

  Widget _buildSmallCircle(Size size) {
    final diameter = min(size.height, size.width) * 0.15;
    const double margin = 16;
    const alpha = 30;
    return Positioned(
      left: margin,
      top: _calcColorBoxHeight(size) - diameter - margin,
      child: Container(
        width: diameter,
        height: diameter,
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(alpha),
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _buildBigCircle(Size size) {
    final diameter = min(size.height, size.width) * 0.4;
    const double margin = 16;
    const alpha = 20;
    return Positioned(
      right: margin,
      top: margin,
      child: Container(
        width: diameter,
        height: diameter,
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(alpha),
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _buildAppName(Size size, ThemeData theme) {
    const fontFamily = 'JbMono';
    return SizedBox(
      width: size.width,
      height: _calcColorBoxHeight(size),
      child: ResponsivePadding(
        child: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'fitiavana',
                style: TextStyle(
                  fontSize: 48,
                  fontFamily: fontFamily,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 4,
                  bottom: 4,
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondary,
                  borderRadius: const BorderRadius.all(Radius.circular(32)),
                ),
                child: const Text(
                  'voalohany',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontFamily: fontFamily,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final coloredBoxHeight = size.height * 0.4;
    final theme = Theme.of(context);
    return Scaffold(
      floatingActionButton: floatingActionButton,
      body: Stack(
        children: [
          _buildColoredContainer(size, theme),
          _buildSmallCircle(size),
          _buildBigCircle(size),
          _buildAppName(size, theme),
          SizedBox(
            width: size.width,
            height: size.height,
            child: ResponsivePadding(
              child: Column(
                children: [
                  SizedBox(height: coloredBoxHeight + 16),
                  body,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
