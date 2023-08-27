import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final void Function() onPressed;

  const ActionButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      child: Row(
        children: [
          Text(label),
          // Use spacing from theme
          const SizedBox(width: 4),
          Icon(icon),
        ],
      ),
    );
  }
}
