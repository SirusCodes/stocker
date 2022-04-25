import 'package:flutter/material.dart';

import 'features/home/presentation/home_base.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const List<Widget> _homeScreens = [
    SizedBox.shrink(),
    SizedBox.shrink(),
    SizedBox.shrink(),
    SizedBox.shrink(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stocker',
      theme: ThemeData(
        useMaterial3: true,
        navigationBarTheme: const NavigationBarThemeData(
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6a040f),
        ),
      ),
      home: const HomeBase(screens: _homeScreens),
    );
  }
}
