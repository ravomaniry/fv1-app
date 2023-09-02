import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

AppBar buildAppBar(BuildContext context, bool backButton, Key? backButtonKey) {
  final theme = Theme.of(context);
  return AppBar(
    leading: backButton
        ? BackButton(
            color: theme.colorScheme.primary,
            key: backButtonKey,
            onPressed: () {
              if (GoRouter.of(context).canPop()) {
                GoRouter.of(context).pop();
              } else {
                GoRouter.of(context).go('/');
              }
            },
          )
        : null,
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
