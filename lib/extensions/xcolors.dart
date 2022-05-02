import 'package:flutter/material.dart';

extension XColors on Color {
  Color get blackOrWhiteForForeground {
    return ThemeData.estimateBrightnessForColor(this) == Brightness.dark
        ? Colors.white
        : Colors.black;
  }
}
