import 'package:flutter/material.dart';

import 'colors.dart';

class AppTheme {
  static ThemeData themeData(bool _isDarkTheme, BuildContext context) {
    // TODO:Caleb When you have time, migrate to material3
    // We have about a year to migrate
    // But I don't like it's look
    // Sad :(
    if (_isDarkTheme) {
      return ThemeData(
        brightness: Brightness.dark,
        fontFamily: "Roboto",
        primarySwatch: Colors.blue,
        primaryColor: OdiColors.appColor,
        useMaterial3: false,
      );
    } else {
      return ThemeData(
        brightness: Brightness.light,
        fontFamily: "Roboto",
        primarySwatch: Colors.blue,
        primaryColor: OdiColors.appColor,
        useMaterial3: false,
      );
    }
  }
}
