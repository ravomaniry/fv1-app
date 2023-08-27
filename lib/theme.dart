import 'package:flutter/material.dart';

ThemeData createTheme() {
  Map<int, Color> black = {
    50: Colors.black12,
    100: Colors.black12,
    200: Colors.black26,
    300: Colors.black38,
    400: Colors.black45,
    500: Colors.black54,
    600: Colors.black54,
    700: Colors.black87,
    800: Colors.black87,
    900: Colors.black,
  };
  return ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(color: Colors.black),
    ),
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: MaterialColor(0xFF000000, black),
      accentColor: Colors.deepOrange,
    ),
  );
}
