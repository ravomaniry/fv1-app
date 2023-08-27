import 'package:flutter/material.dart';
import 'package:fv1/ui/widgets/action_button.dart';
import 'package:fv1/ui/widgets/app_bar.dart';
import 'package:fv1/ui/widgets/home_card.dart';

class ExplorerScreen extends StatelessWidget {
  static const route = '/explorer';

  const ExplorerScreen({super.key});

  Widget _buildActionButton() {
    return ActionButton(
      label: 'ALAINA',
      icon: Icons.download_rounded,
      onPressed: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Column(
        children: [
          HomeCard(
            title: 'Fahasoavana sy finoana',
            subtitle: 'Mianara mampiaraka ny herin\'ny fahasoavan\''
                'Andriamanitra sy ny finoana hahazoana vokatra mahagaga.',
            actionButton: _buildActionButton(),
          ),
          HomeCard(
            title: 'Fitiavana voalohany',
            subtitle: 'Hianarana amin\'ny ankapobeny ny fototry ny'
                'fifandraisana amin\'Andriamanitra.',
            actionButton: _buildActionButton(),
          ),
        ],
      ),
    );
  }
}
