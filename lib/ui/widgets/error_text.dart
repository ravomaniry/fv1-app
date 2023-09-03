import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {
  final String data;

  const ErrorText(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(color: Theme.of(context).colorScheme.error),
    );
  }
}
