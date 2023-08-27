import 'package:flutter/material.dart';

class ScreenH1 extends StatelessWidget {
  final String title;

  const ScreenH1(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
