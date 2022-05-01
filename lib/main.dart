import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/home/presentation/home_base.dart';
import 'shared/providers/theme_provider.dart';
import 'utils/route_generator.dart';
import 'utils/themes.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return MaterialApp(
      title: 'Stocker',
      themeMode: themeMode,
      theme: theme,
      darkTheme: darkTheme,
      onGenerateRoute: RouteGenerator.onGenerateRoute,
      home: const HomeBase(),
    );
  }
}
