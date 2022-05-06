import 'package:flutter/material.dart';

import '../../../extensions/extensions.dart';

class StoreManagerScreen extends StatelessWidget {
  const StoreManagerScreen({Key? key}) : super(key: key);

  static const path = "/store-manager";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Store manager"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add_rounded),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) => ListTile(
          title: const Text("Name"),
          subtitle: const Text("name@email.com"),
          leading: CircleAvatar(child: Text("Name".avatarString)),
          trailing: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.delete_rounded),
          ),
        ),
      ),
    );
  }
}
