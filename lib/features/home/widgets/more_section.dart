import 'package:flutter/material.dart';

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
        ListTile(
          leading: const CircleAvatar(child: Icon(Icons.color_lens_rounded)),
          title: const Text("Theme"),
          subtitle: const Text("Change app theme"),
          onTap: () {},
        ),
        ListTile(
          leading: const CircleAvatar(child: Icon(Icons.history_rounded)),
          title: const Text("Sales history"),
          subtitle: const Text("View history of all the sales"),
          onTap: () {},
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
}
