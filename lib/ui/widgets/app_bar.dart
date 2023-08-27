import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context) {
  final theme = Theme.of(context);
  return AppBar(
    centerTitle: false,
    leadingWidth: 0,
    title: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'FITIAVANA',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
            fontStyle: FontStyle.italic,
            fontSize: 24,
          ),
        ),
        Text(
          'V1',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.secondary,
            fontSize: 20,
          ),
        ),
      ],
    ),
  );
}
