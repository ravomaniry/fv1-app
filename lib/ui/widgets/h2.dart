import 'package:flutter/material.dart';

class ScreenH2 extends StatelessWidget {
  final String title;
  final Key? textKey;
  final Color? color;

  const ScreenH2(this.title, {super.key, this.textKey, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(color: color),
      key: textKey,
    );
  }
}
