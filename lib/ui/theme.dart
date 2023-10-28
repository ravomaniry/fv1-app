import 'package:flutter/material.dart';

const double borderRadios = 8;

ThemeData createTheme() {
  const bgColor = Color(0xffececec);
  final primary = _createMaterialColor(const Color(0xff402bff));
  const accent = Colors.deepOrange;
  return ThemeData(
    unselectedWidgetColor: Colors.black38,
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      backgroundColor: bgColor,
      elevation: 0,
      titleTextStyle: TextStyle(color: Colors.black),
    ),
    scaffoldBackgroundColor: bgColor,
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: primary,
      accentColor: accent,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadios),
        ),
      ),
    ),
    cardTheme: const CardTheme(
      elevation: 1,
      margin: EdgeInsets.only(left: 8, right: 8, bottom: 4),
    ),
    listTileTheme: ListTileThemeData(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      selectedTileColor: Colors.white,
      selectedColor: Colors.black,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: primary.shade600,
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
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      elevation: 2,
      backgroundColor: accent,
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(foregroundColor: primary.shade500),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      linearTrackColor: Colors.black12,
      color: accent,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      shape: RoundedRectangleBorder(),
      backgroundColor: Colors.black,
    ),
    dividerTheme: DividerThemeData(thickness: 1, color: accent.shade500),
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
