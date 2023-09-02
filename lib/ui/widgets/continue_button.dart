import 'package:flutter/material.dart';

import 'action_button.dart';

class ContinueButton extends StatelessWidget {
  static const buttonKey = Key('ContinueButton');
  final String label;
  final void Function() onPressed;

  const ContinueButton(
      {super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ActionButton(
          label: label,
          key: buttonKey,
          icon: Icons.chevron_right,
          onPressed: onPressed,
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.02),
      ],
    );
  }
}
