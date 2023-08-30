import 'package:flutter/material.dart';

class AppIconButton extends StatelessWidget {
  final void Function() onPressed;
  final IconData icon;

  const AppIconButton({super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      style: Theme.of(context).iconButtonTheme.style,
      icon: Icon(icon),
    );
  }
}
