import 'package:flutter/material.dart';

final theme = ThemeData(
  useMaterial3: true,
  navigationBarTheme: const NavigationBarThemeData(
    labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
  ),
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF6a040f),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(),
  ),
);

final darkTheme = ThemeData(
  useMaterial3: true,
  navigationBarTheme: const NavigationBarThemeData(
    labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
  ),
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color(0xFF6a040f),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(),
  ),
);
