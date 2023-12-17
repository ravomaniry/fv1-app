import 'package:flutter/material.dart';
import 'package:fv1/extensions/context.dart';

class ErrorText extends StatelessWidget {
  final String data;
  final Key? widgetKey;

  const ErrorText(this.data, {super.key, this.widgetKey});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      key: widgetKey,
      style: TextStyle(color: context.themeErrorColor),
    );
  }
}
