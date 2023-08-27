import 'package:flutter/material.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'FITIAVANA',
          style: TextStyle(
            color: theme.colorScheme.primary,
            fontSize: 24,
          ),
        ),
        Text(
          'V1',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.secondary,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
