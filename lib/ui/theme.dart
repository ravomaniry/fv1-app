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
  const bgColor = Color(0xff5c4aff);
  return ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: bgColor,
      elevation: 0,
      titleTextStyle: TextStyle(color: Colors.black),
    ),
    scaffoldBackgroundColor: bgColor,
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: MaterialColor(0xff5c4aff, black),
      accentColor: Colors.deepOrange,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    ),
    cardTheme: const CardTheme(elevation: 0),
  );
}
