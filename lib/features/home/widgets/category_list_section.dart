import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/widgets/category_list_tile.dart';
import '../../../shared/widgets/sort_button.dart';
import '../../category/domain/domain.dart';
import '../../category/presentation/save_category_screen.dart';
import '../../category/providers/category_provider.dart';
import '../../product/presentation/product_base_screen.dart';

const _categoryList = [
  CategoryModel(name: "Name zero", color: Colors.amber, productCount: 10),
  CategoryModel(name: "Name one", color: Colors.red, productCount: 5),
  CategoryModel(name: "Name two", color: Colors.blue, productCount: 55),
];

class CategoryListSection extends ConsumerStatefulWidget {
  const CategoryListSection({Key? key}) : super(key: key);

  @override
  ConsumerState<CategoryListSection> createState() =>
      _CategoryListSectionState();
}

class _CategoryListSectionState extends ConsumerState<CategoryListSection> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_loadMore);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController
      ..removeListener(_loadMore)
      ..dispose();
  }

  void _loadMore() {
    if (_scrollController.position.extentAfter < 50) {
      ref.read(categoryProvider.notifier).getMoreCategories();
    }
  }

  @override
  Widget build(BuildContext context) {
    final sort = ref.watch(categorySortProvider);
    return NestedScrollView(
      controller: _scrollController,
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
              selectedSort: sort,
              onSelected: (sort) =>
                  ref.read(categorySortProvider.notifier).state = sort,
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
      body: ref.watch(categoryProvider).when(
            data: (categories) {
              return ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return CategoryListTile(
                    category: category,
                    onTap: () => Navigator.pushNamed(
                      context,
                      ProductBaseScreen.path,
                      arguments: category,
                    ),
                  );
                },
              );
            },
            error: (_, __) => const Center(
              child: Text("Something went wrong"),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
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
          ProductBaseScreen.path,
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
          ProductBaseScreen.path,
          arguments: result[index],
        ),
      ),
    );
  }
}
