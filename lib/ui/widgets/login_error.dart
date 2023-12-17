import 'package:flutter/material.dart';
import 'package:fv1/extensions/context.dart';
import 'package:fv1/models/texts.dart';
import 'package:fv1/types/exceptions.dart';

class LoginError extends StatelessWidget {
  static const textKey = Key('LoginError');
  final dynamic error;
  final AppTexts texts;

  const LoginError({super.key, required this.error, required this.texts});

  String _getErrorMsg() {
    return error is AppException
        ? (error as AppException).getMessage(texts)
        : texts.errorUnknown;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _getErrorMsg(),
      key: textKey,
      style: TextStyle(color: context.themeErrorColor),
    );
  }
}
