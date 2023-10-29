import 'package:flutter/material.dart';
import 'package:fv1/providers/app_state.dart';
import 'package:fv1/providers/browser_state.dart';
import 'package:fv1/ui/routes.dart';
import 'package:fv1/ui/widgets/app_container.dart';
import 'package:fv1/ui/widgets/card_container.dart';
import 'package:fv1/ui/widgets/loader.dart';
import 'package:fv1/ui/widgets/no_data_message.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ExplorerScreen extends StatelessWidget {
  static const backButtonKey = Key('ExplorerBackButton');

  const ExplorerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<AppState, BrowserState>(
        builder: (_, appState, state, __) => _Body(appState, state));
  }
}

class _Body extends StatefulWidget {
  final BrowserState _state;
  final AppState _appState;

  const _Body(this._appState, this._state);

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  void initState() {
    super.initState();
    widget._state.loadTeachingsList();
  }

  void _onOpen(int id) async {
    await widget._state.startTeaching(id);
    if (context.mounted) {
      GoRouter.of(context).pushReplacementNamed(
        Routes.teachingSummary,
        pathParameters: {Routes.teachingIdKey: id.toString()},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      backButton: true,
      backButtonKey: ExplorerScreen.backButtonKey,
      body: WrapInLoader(
        isReady: widget._state.teachingsList != null,
        builder: () => widget._state.teachingsList!.isEmpty
            ? NoDataMessage(widget._appState.texts.noNewTeaching)
            : ListView(
                children: [
                  for (final teaching in widget._state.teachingsList!)
                    CardContainer(
                      child: ListTile(
                        title: Text(teaching.title),
                        subtitle: Text(teaching.subtitle),
                        trailing: Icon(
                          Icons.chevron_right,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        onTap: () => _onOpen(teaching.id),
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}
