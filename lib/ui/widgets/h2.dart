import 'package:flutter/material.dart';

class ScreenH2 extends StatelessWidget {
  final String title;
  final Key? textKey;

  const ScreenH2(this.title, {super.key, this.textKey});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleSmall,
      key: textKey,
    );
  }
}
