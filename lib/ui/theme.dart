import 'package:flutter/material.dart';

ThemeData createTheme() {
  const bgColor = Color(0xfff4f4f4);
  final primary = _createMaterialColor(const Color(0xff5c4aff));
  return ThemeData(
    unselectedWidgetColor: Colors.black38,
    appBarTheme: const AppBarTheme(
      backgroundColor: bgColor,
      elevation: 0,
      titleTextStyle: TextStyle(color: Colors.black),
    ),
    scaffoldBackgroundColor: bgColor,
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: primary,
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
    listTileTheme: const ListTileThemeData(
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateColor.resolveWith(
        (states) {
          if (states.contains(MaterialState.disabled)) {
            return Colors.grey;
          }
          return states.contains(MaterialState.selected)
              ? primary.shade500
              : Colors.black38;
        },
      ),
    ),
  );
}

MaterialColor _createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}
