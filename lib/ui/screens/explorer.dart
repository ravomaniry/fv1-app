import 'package:flutter/material.dart';
import 'package:fv1/providers/browser_state.dart';
import 'package:fv1/ui/router_utils.dart';
import 'package:fv1/ui/screens/teaching_summary.dart';
import 'package:fv1/ui/widgets/app_container.dart';
import 'package:fv1/ui/widgets/icon_button.dart';
import 'package:fv1/ui/widgets/loader.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ExplorerScreen extends StatelessWidget {
  static const route = '/explorer';

  const ExplorerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BrowserState>(builder: (_, state, __) => _Body(state));
  }
}

class _Body extends StatefulWidget {
  final BrowserState _state;

  const _Body(this._state);

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  void initState() {
    super.initState();
    widget._state.loadTeachingsList();
  }

  Widget _buildActionButton() {
    return AppIconButton(
      onPressed: () => _onDownload(),
      icon: Icons.download_rounded,
    );
  }

  void _onOpen(int id) async {
    await widget._state.startTeaching(id);
    if (context.mounted) {
      GoRouter.of(context).goNamed(
        TeachingSummaryScreen.route,
        pathParameters: {teachingIdKey: id.toString()},
      );
    }
  }

  void _onDownload() {}

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      body: WrapInLoader(
        isReady: widget._state.teachingsList != null,
        builder: () => ListView(
          children: [
            for (final teaching in widget._state.teachingsList!)
              ListTile(
                title: Text(teaching.title),
                subtitle: Text(teaching.subtitle),
                trailing: _buildActionButton(),
                onTap: () => _onOpen(teaching.id),
              ),
          ],
        ),
      ),
    );
  }
}
