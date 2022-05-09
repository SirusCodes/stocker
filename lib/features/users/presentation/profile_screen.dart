import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/user_provider.dart';
import 'update_password_screen.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  static const path = "/profile-screen";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: ref.watch(userProvider).when(
            data: (user) {
              return Column(
                children: [
                  const ListTile(
                    title: Text("Darshan"),
                    leading: Icon(Icons.person_rounded),
                  ),
                  const ListTile(
                    title: Text("darshan@email.com"),
                    leading: Icon(Icons.email_rounded),
                  ),
                  const Divider(),
                  ListTile(
                    title: const Text("Update password"),
                    leading: const Icon(Icons.lock_rounded),
                    onTap: () => Navigator.pushNamed(
                      context,
                      UpdatePasswordScreen.path,
                    ),
                  ),
                ],
              );
            },
            error: (_, __) => const Center(
              child: Text("Something went wrong..."),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
    );
  }
}
