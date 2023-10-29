import 'package:flutter/material.dart';
import 'package:fv1/providers/app_state.dart';
import 'package:provider/provider.dart';

enum _MenuActions {
  logout,
}

class AppBarActionButton extends StatelessWidget {
  static const userButtonKey = Key('AppBarActionButton');
  static const logoutButtonKey = Key('LogOutButton');

  const AppBarActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(builder: (_, state, __) => _Body(state));
  }
}

class _Body extends StatelessWidget {
  final AppState _state;

  const _Body(this._state);

  _onSelected(_MenuActions? action) {
    _state.logOut();
  }

  @override
  Widget build(BuildContext context) {
    final primColor = Theme.of(context).colorScheme.primary;
    return _state.user == null
        ? const SizedBox.shrink()
        : PopupMenuButton<_MenuActions?>(
            onSelected: _onSelected,
            child: const CircleAvatar(
              key: AppBarActionButton.userButtonKey,
              child: Icon(
                Icons.account_circle_rounded,
                color: Colors.white,
              ),
            ),
            itemBuilder: (_) => [
              PopupMenuItem(
                value: null,
                child: Row(
                  children: [
                    const Icon(Icons.account_circle_outlined),
                    const SizedBox(width: 8),
                    Text(_state.user!.username),
                  ],
                ),
              ),
              const PopupMenuDivider(height: 1),
              PopupMenuItem(
                key: AppBarActionButton.logoutButtonKey,
                value: _MenuActions.logout,
                child: Row(
                  children: [
                    Icon(Icons.logout, color: primColor),
                    const SizedBox(width: 8),
                    Text(
                      _state.texts.logOut,
                      style: TextStyle(color: primColor),
                    ),
                  ],
                ),
              ),
            ],
          );
  }
}
