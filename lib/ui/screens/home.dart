import 'package:flutter/material.dart';
import 'package:fv1/ui/screens/explorer.dart';
import 'package:fv1/ui/screens/teaching_summary.dart';
import 'package:fv1/ui/widgets/action_button.dart';
import 'package:fv1/ui/widgets/app_container.dart';
import 'package:fv1/ui/widgets/home_card.dart';
import 'package:fv1/ui/widgets/search_button.dart';

class HomeScreen extends StatelessWidget {
  static const route = '';

  const HomeScreen({super.key});

  void _goToExplorer(BuildContext context) {
    Navigator.of(context).pushNamed(ExplorerScreen.route);
  }

  void _onTeachingSelected(BuildContext context) {
    Navigator.of(context).pushNamed(TeachingSummaryScreen.route);
  }

  Widget _buildActionButton(BuildContext context) {
    return ActionButton(
      label: 'TOHIZANA',
      icon: Icons.chevron_right,
      onPressed: () => _onTeachingSelected(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      floatingActionButton: SearchButton(
        onPressed: () => _goToExplorer(context),
      ),
      body: Column(
        children: [
          HomeCard(
            title: 'Fahasoavana sy finoana',
            subtitle: 'Mianara mampiaraka ny herin\'ny fahasoavan\''
                'Andriamanitra sy ny finoana hahazoana vokatra mahagaga.',
            actionButton: _buildActionButton(context),
          ),
          HomeCard(
            title: 'Fitiavana voalohany',
            subtitle: 'Hianarana amin\'ny ankapobeny ny fototry ny'
                'fifandraisana amin\'Andriamanitra.',
            actionButton: _buildActionButton(context),
          ),
        ],
      ),
    );
  }
}
