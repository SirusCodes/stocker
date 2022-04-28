import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/providers/theme_provider.dart';
import '../../transaction/presentation/transaction_history_screen.dart';

class MoreSection extends StatelessWidget {
  const MoreSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const CircleAvatar(child: Icon(Icons.person)),
          title: const Text("Darshan Rander"),
          subtitle: const Text("darshandrander@gmail.com"),
          onTap: () {},
        ),
        ListTile(
          leading: const CircleAvatar(child: Icon(Icons.share_rounded)),
          title: const Text("Share/Revoke shop access"),
          subtitle: const Text("Add or remove access to your shop"),
          onTap: () {},
        ),
        ListTile(
          leading: const CircleAvatar(child: Icon(Icons.access_time_rounded)),
          title: const Text("Current stock"),
          subtitle: const Text("View the list of current product quantity"),
          onTap: () {},
        ),
        Consumer(
          builder: (context, ref, child) => ListTile(
            leading: const CircleAvatar(child: Icon(Icons.color_lens_rounded)),
            title: const Text("Theme"),
            subtitle: const Text("Change app theme"),
            onTap: () async {
              final theme = await _showThemeSelector(
                context: context,
                selected: _getCurrentThemeMode(context),
              );

              if (theme == null) return;

              ref.read(themeProvider.notifier).setTheme(theme);
            },
          ),
        ),
        ListTile(
          leading: const CircleAvatar(child: Icon(Icons.history_rounded)),
          title: const Text("Transaction history"),
          subtitle: const Text("View history of all the transaction"),
          onTap: () => Navigator.pushNamed(
            context,
            TransactionHistoryScreen.path,
          ),
        ),
        const Spacer(),
        ListTile(
          leading: const CircleAvatar(child: Icon(Icons.logout_rounded)),
          title: const Text("Log out"),
          subtitle: const Text("Log out current user"),
          onTap: () {},
        ),
      ],
    );
  }

  ThemeMode _getCurrentThemeMode(BuildContext context) {
    final currentTheme = Theme.of(context).colorScheme.brightness;

    switch (currentTheme) {
      case Brightness.dark:
        return ThemeMode.dark;
      case Brightness.light:
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }

  Future<ThemeMode?> _showThemeSelector({
    required BuildContext context,
    required ThemeMode selected,
  }) {
    return showDialog<ThemeMode>(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text("Select Theme"),
        children: [
          RadioListTile<ThemeMode>(
            title: const Text("System Default"),
            value: ThemeMode.system,
            groupValue: selected,
            onChanged: (theme) => _onThemeChanged(context, theme),
          ),
          RadioListTile<ThemeMode>(
            title: const Text("Light"),
            value: ThemeMode.light,
            groupValue: selected,
            onChanged: (theme) => _onThemeChanged(context, theme),
          ),
          RadioListTile<ThemeMode>(
            title: const Text("Dark"),
            value: ThemeMode.dark,
            groupValue: selected,
            onChanged: (theme) => _onThemeChanged(context, theme),
          ),
        ],
      ),
    );
  }

  void _onThemeChanged(BuildContext context, ThemeMode? theme) {
    return Navigator.pop(context, theme);
  }
}
