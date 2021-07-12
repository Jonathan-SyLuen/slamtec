import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData get lightTheme {
    return ThemeData(
        primarySwatch: Colors.amber,
        sliderTheme: SliderThemeData(
          trackHeight: 6.0,
        ));
  }
}
