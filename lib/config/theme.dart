import 'package:flutter/material.dart';

import 'config.dart';

class ThemeApp {
  static lightTheme() {
    return ThemeData(
        primaryColor: Palette.primaryColor,
        shadowColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black
        ),
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black)),
        primarySwatch: Palette.swatch);
  }
}
