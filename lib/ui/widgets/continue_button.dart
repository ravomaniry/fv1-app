import 'package:flutter/material.dart';

import 'action_button.dart';

class ContinueButton extends StatelessWidget {
  final void Function() onPressed;

  const ContinueButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ActionButton(
      label: 'TOHIZANA',
      icon: Icons.chevron_right,
      onPressed: onPressed,
    );
  }
}
