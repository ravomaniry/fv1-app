import 'package:flutter/material.dart';

class ScreenH3 extends StatelessWidget {
  final String title;
  final Key? textKey;

  const ScreenH3(this.title, {super.key, this.textKey});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleSmall,
      key: textKey,
    );
  }
}
