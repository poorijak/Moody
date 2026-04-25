import 'package:flutter/material.dart';
import 'package:moody_app/themes/colors.dart';

class AppTheme {
  static final customTextTheme = TextTheme(
    bodyMedium: TextStyle(fontSize: 16),
    bodyLarge: TextStyle(fontSize: 24),
  );

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: false,
    fontFamily: 'Advercase',
    textTheme: customTextTheme,
    primaryColor: primary,
    primaryColorDark: primary,
    primaryColorLight: primary,
    hoverColor: border,
    hintColor: mutedforeground,
    colorScheme: const ColorScheme.light(primary: primary),
    iconTheme: const IconThemeData(color: black),
    scaffoldBackgroundColor: background,
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
        color: icons,
        fontFamily: 'Advercase',
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      backgroundColor: primary,
      foregroundColor: icons,
      iconTheme: IconThemeData(color: icons),
    ),
  );
}
