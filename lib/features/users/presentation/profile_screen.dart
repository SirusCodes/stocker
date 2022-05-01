import 'package:flutter/material.dart';

import 'update_password_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  static const path = "/profile-screen";

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _nameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ValueListenableBuilder(
              valueListenable: _nameController,
              builder: (context, value, _) => TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "Name",
                  hintText: "Enter your name",
                  suffixIcon: _showSaveIcon
                      ? IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.save_rounded),
                        )
                      : null,
                ),
              ),
            ),
          ),
          const Divider(),
          const ListTile(
            title: Text("darshan@email.com"),
            leading: Icon(Icons.email_rounded),
          ),
          ListTile(
            title: const Text("Update password"),
            leading: const Icon(Icons.lock_rounded),
            onTap: () => Navigator.pushNamed(
              context,
              UpdatePasswordScreen.path,
            ),
          ),
        ],
      ),
    );
  }

  // TODO: check if name is changed
  bool get _showSaveIcon => _nameController.text.isNotEmpty;
}
