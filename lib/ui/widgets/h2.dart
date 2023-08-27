import 'package:flutter/material.dart';

class ScreenH2 extends StatelessWidget {
  final String title;

  const ScreenH2(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleSmall,
    );
  }
}
