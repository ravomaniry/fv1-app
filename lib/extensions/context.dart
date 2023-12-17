import 'package:flutter/material.dart';

extension ColorAccessors on BuildContext {
  Color get themePrimaryColor => Theme.of(this).primaryColor;

  Color get themeSecondaryColor => Theme.of(this).colorScheme.secondary;

  Color get themeErrorColor => Theme.of(this).colorScheme.error;
}
