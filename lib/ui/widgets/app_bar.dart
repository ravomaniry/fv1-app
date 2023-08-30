import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context) {
  final theme = Theme.of(context);
  return AppBar(
    centerTitle: false,
    leadingWidth: 0,
    leading: BackButton(color: theme.colorScheme.primary),
    actions: [
      Icon(Icons.more_vert, color: theme.colorScheme.primary),
    ],
    title: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'FITIAVANA',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
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
