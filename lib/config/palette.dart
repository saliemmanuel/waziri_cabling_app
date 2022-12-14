import 'package:flutter/material.dart';

class Palette {
  static const Color scaffold = Color(0xFFFFFFFF);
  static const Color grey = Color.fromARGB(117, 230, 227, 227);
  static const Color appBarColor = Color(0xFF1D976C);
  static const Color sideBarColor = Color(0xFF1C212D);
  static const Color backgroundColor = Color.fromARGB(255, 227, 235, 243);
  static const Color fadeColors = Color(0xFFF3F8FC);
  static const Color teal = Colors.teal;
  static const Color red = Colors.red;

  static const Color primaryColor = Color(0xFF1B00FF);
  static const MaterialColor swatch = MaterialColor(0xFF1B00FF, {
    50: Color(0xFFFFFFFF),
    60: Color(0xFFFFFFFF),
    70: Color(0xFFFFFFFF),
    80: Color(0xFFFFFFFF),
    90: Color(0xFFFFFFFF),
    100: Color(0xFFFFFFFF),
    200: Color(0xFFFFFFFF),
    300: Color(0xFFFFFFFF),
    400: Color(0xFFFFFFFF),
    500: Color(0xFFFFFFFF),
    600: Color(0xFFFFFFFF),
    700: Color(0xFFFFFFFF),
    800: Color(0xFFFFFFFF),
    900: Color(0xFFFFFFFF),
  });
  static const LinearGradient createRoomGradient = LinearGradient(
    colors: [Color(0xFF1B00FF), Color(0xFFCE48B1)],
  );
  static const Color appBarBackgroundColor = Color(0xFFFFFFFF);
  static const Color online = Color(0xFF4BCB1F);

  static const LinearGradient storyGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.transparent, Colors.black26],
  );
}
