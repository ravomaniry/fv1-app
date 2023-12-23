import 'package:flutter/material.dart';
import 'package:fv1/extensions/context.dart';
import 'package:fv1/providers/app_state.dart';
import 'package:fv1/ui/widgets/help_button.dart';
import 'package:provider/provider.dart';

enum _MenuActions {
  logout,
  help,
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

  _onSelected(_MenuActions? action, BuildContext context) {
    if (action == _MenuActions.logout) {
      _state.logOut();
    } else if (action == _MenuActions.help) {
      context.goToHelpScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    final primColor = context.themePrimaryColor;
    return _state.user == null
        ? const SizedBox.shrink()
        : PopupMenuButton<_MenuActions?>(
            onSelected: (action) => _onSelected(action, context),
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
                child: _MenuButton(
                  _state.user!.username,
                  Icons.account_circle_outlined,
                ),
              ),
              PopupMenuItem(
                value: _MenuActions.help,
                child: _MenuButton(_state.texts.helpTitle, Icons.help),
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

class _MenuButton extends StatelessWidget {
  final String _text;
  final IconData _icon;

  const _MenuButton(this._text, this._icon);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(_icon),
        const SizedBox(width: 8),
        Text(_text),
      ],
    );
  }
}
