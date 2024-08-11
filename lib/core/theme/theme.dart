import 'package:bloggers_hub/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static _border(Color color) => OutlineInputBorder(
        borderSide: BorderSide(color: color, width: 3),
        borderRadius: BorderRadius.circular(10),
      );
  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Pallete.backgroundColor,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.all(27),
      focusedBorder: _border(Pallete.gradient2),
      enabledBorder: _border(Pallete.borderColor),
    ),
    chipTheme: const ChipThemeData(
        backgroundColor: Pallete.backgroundColor,
        side: BorderSide.none,
        selectedColor: Pallete.gradient1,
        ),
  );
}
