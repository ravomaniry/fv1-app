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
          'fitia',
          style: TextStyle(
            fontFamily: 'JbMono',
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
            fontSize: 20,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 8, right: 8),
          margin: const EdgeInsets.only(left: 4),
          decoration: BoxDecoration(
              color: theme.colorScheme.secondary,
              borderRadius: const BorderRadius.all(Radius.circular(12))),
          child: const Text(
            'v1',
            style: TextStyle(
              fontFamily: 'JbMono',
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ),
      ],
    ),
  );
}
