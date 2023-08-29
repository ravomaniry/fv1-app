import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context) {
  final theme = Theme.of(context);
  return AppBar(
    centerTitle: false,
    leadingWidth: 0,
    leading: const BackButton(),
    actions: const [
      Icon(Icons.more_vert),
    ],
    title: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'FITIAVANA',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
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
