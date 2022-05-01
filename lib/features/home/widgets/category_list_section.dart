import 'package:flutter/material.dart';

import '../../../enums/enums.dart';
import '../../../shared/widgets/category_list_tile.dart';
import '../../../shared/widgets/sort_button.dart';
import '../../category/domain/domain.dart';
import '../../category/presentation/save_category_screen.dart';

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
            IconButton(
              onPressed: () => Navigator.pushNamed(
                context,
                SaveCategoryScreen.path,
              ),
              icon: const Icon(Icons.add_rounded),
            ),
            SortButton(
              selectedSort: Sort.ascAlpha,
              onSelected: (sort) {},
            ),
            IconButton(
              onPressed: () => showSearch(
                context: context,
                delegate: _CategorySearchDelegate(),
              ),
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
          return CategoryListTile(
            category: category,
            onTap: () => Navigator.pushNamed(
              context,
              SaveCategoryScreen.path,
              arguments: category,
            ),
          );
        },
      ),
    );
  }
}

class _CategorySearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: query.isNotEmpty ? () => query = "" : null,
        icon: const Icon(Icons.clear_rounded),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back_rounded),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) return const SizedBox.shrink();

    final result = _categoryList //
        .where((cat) => cat.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: result.length,
      itemBuilder: (context, index) => CategoryListTile(
        category: result[index],
        onTap: () => Navigator.pushNamed(
          context,
          SaveCategoryScreen.path,
          arguments: result[index],
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final result = _categoryList //
        .where((cat) => cat.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: result.length,
      itemBuilder: (context, index) => CategoryListTile(
        category: result[index],
        onTap: () => Navigator.pushNamed(
          context,
          SaveCategoryScreen.path,
          arguments: result[index],
        ),
      ),
    );
  }
}
