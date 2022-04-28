import 'package:flutter/material.dart';

import '../../../enums/enums.dart';
import '../../../extensions/extensions.dart';
import '../../../shared/widgets/sort_button.dart';
import '../../category/domain/domain.dart';

const _categoryList = [
  CategoryModel(name: "Name zero", color: Colors.amber, productCount: 10),
  CategoryModel(name: "Name one", color: Colors.red, productCount: 5),
  CategoryModel(name: "Name two", color: Colors.blue, productCount: 55),
];

class CategoryListSection extends StatelessWidget {
  const CategoryListSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverAppBar(
          title: const Text("Stocker"),
          actions: [
            SortButton(
              selectedSort: Sort.ascAlpha,
              onSelected: (sort) {},
            ),
            IconButton(
              onPressed: () {},
              tooltip: "Search category ",
              icon: const Icon(Icons.search_rounded),
            ),
          ],
        ),
      ],
      body: ListView.builder(
        itemCount: _categoryList.length,
        itemBuilder: (context, index) {
          final category = _categoryList[index];
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
            onTap: () {},
          );
        },
      ),
    );
  }
}
