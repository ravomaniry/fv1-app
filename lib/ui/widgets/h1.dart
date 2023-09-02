import 'package:flutter/material.dart';

class ScreenH1 extends StatelessWidget {
  final String title;
  final Key? textKey;

  const ScreenH1(this.title, {super.key, this.textKey});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        key: textKey,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
