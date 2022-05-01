import 'package:flutter/material.dart';

import '../../enums/enums.dart';
import '../../extensions/extensions.dart';
import '../../features/category/domain/domain.dart';
import '../../features/category/presentation/save_category_screen.dart';

class CategoryListTile extends StatelessWidget {
  const CategoryListTile({
    Key? key,
    required this.category,
    required this.onTap,
  }) : super(key: key);

  final CategoryModel category;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: FittedBox(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              category.name.avatarString,
              style: TextStyle(
                color: category.color.blackOrWhiteForForeground,
              ),
            ),
          ),
        ),
        backgroundColor: category.color,
      ),
      title: Text(category.name),
      subtitle: Text("${category.productCount} product"),
      trailing: PopupMenuButton<ListMenu>(
        tooltip: "Category menu",
        onSelected: (value) {
          if (value == ListMenu.edit) {
            Navigator.pushNamed(
              context,
              SaveCategoryScreen.path,
              arguments: category,
            );
          }
        },
        itemBuilder: (context) => const [
          PopupMenuItem(
            value: ListMenu.edit,
            child: Text("Edit"),
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}
