import 'package:flutter/material.dart';
import 'package:fv1/ui/routes.dart';
import 'package:go_router/go_router.dart';

extension RouterExtensions on BuildContext {
  void goToHelpScreen() {
    push(Routes.help);
  }
}

class HelpButton extends StatelessWidget {
  static const buttonKey = Key('HelpButton');
  final Color color;

  const HelpButton({super.key, this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      key: buttonKey,
      onPressed: context.goToHelpScreen,
      icon: Icon(
        Icons.help,
        color: color,
      ),
    );
  }
}

class HelpFAB extends StatelessWidget {
  const HelpFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: context.goToHelpScreen,
      child: const HelpButton(),
    );
  }
}
