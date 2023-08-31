import 'package:flutter/material.dart';
import 'package:fv1/models/teaching.dart';
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
  static const route = '';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BrowserState>(builder: (_, state, __) => _Body(state));
  }
}

class _Body extends StatelessWidget {
  final BrowserState _appState;

  const _Body(this._appState);

  void _goToExplorer(BuildContext context) {
    context.goNamed(ExplorerScreen.route);
  }

  Widget _buildActionButton(BuildContext context, TeachingModel teaching) {
    return ActionButton(
      label: 'TOHIZANA',
      icon: Icons.chevron_right,
      onPressed: () => context.goNamed(
        TeachingSummaryScreen.route,
        pathParameters: {'id': teaching.id.toString()},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      floatingActionButton: SearchButton(
        onPressed: () => _goToExplorer(context),
      ),
      body: WrapInLoader(
        isReady: _appState.localTeachings != null,
        builder: () => Column(
          children: [
            for (final teaching in _appState.localTeachings!)
              HomeCard(
                title: teaching.title,
                subtitle: teaching.subtitle,
                actionButton: _buildActionButton(context, teaching),
              ),
          ],
        ),
      ),
    );
  }
}
