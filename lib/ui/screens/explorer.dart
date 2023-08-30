import 'package:flutter/material.dart';
import 'package:fv1/providers/explorer_state.dart';
import 'package:fv1/ui/widgets/app_container.dart';
import 'package:fv1/ui/widgets/icon_button.dart';
import 'package:fv1/ui/widgets/loader.dart';
import 'package:provider/provider.dart';

class ExplorerScreen extends StatelessWidget {
  static const route = '/explorer';

  const ExplorerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ExplorerState>(builder: (_, state, __) => _Body(state));
  }
}

class _Body extends StatefulWidget {
  final ExplorerState _state;

  const _Body(this._state);

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  void initState() {
    super.initState();
    widget._state.loadList();
  }

  Widget _buildActionButton() {
    return AppIconButton(
      onPressed: () {},
      icon: Icons.download_rounded,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      body: WrapInLoader(
        isReady: widget._state.teachings != null,
        builder: () => ListView(
          children: [
            for (final teaching in widget._state.teachings!)
              ListTile(
                title: Text(teaching.title),
                subtitle: Text(teaching.subtitle),
                trailing: _buildActionButton(),
              ),
          ],
        ),
      ),
    );
  }
}
