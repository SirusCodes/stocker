import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/widgets/product_list_tile.dart';
import '../../../shared/widgets/sort_button.dart';
import '../../category/domain/domain.dart';
import '../../transaction/widgets/cart_fab.dart';
import '../providers/product_category_provider.dart';
import '../providers/product_provider.dart';
import '../widgets/product_list_section.dart';
import '../widgets/product_statistics_section.dart';
import 'save_product_screen.dart';

class ProductBaseScreen extends StatefulWidget {
  const ProductBaseScreen({Key? key, required this.category}) : super(key: key);

  static const path = "/product-list";

  final CategoryModel category;

  @override
  State<ProductBaseScreen> createState() => _ProductBaseScreenState();
}

class _ProductBaseScreenState extends State<ProductBaseScreen> {
  int _selectedSection = 0;

  static const _screens = [
    ProductListSection(),
    ProductStatisticsSection(),
  ];

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        productCategoryProvider.overrideWithValue(widget.category),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.category.name),
          actions: _selectedSection == 0
              ? [
                  IconButton(
                    onPressed: () => Navigator.pushNamed(
                      context,
                      SaveProductScreen.path,
                      arguments: SaveProductScreenArguments(
                        categoryId: widget.category.id!,
                        categoryColor: widget.category.color,
                      ),
                    ),
                    icon: const Icon(Icons.add_rounded),
                  ),
                  Consumer(
                    builder: (_, ref, __) => SortButton(
                      selectedSort: ref.watch(productSortProvider),
                      onSelected: (sort) {
                        ref.read(productSortProvider.notifier).state = sort;
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () => showSearch(
                      context: context,
                      delegate: _ProductSearchDelegate(),
                    ),
                    icon: const Icon(Icons.search_rounded),
                  ),
                ]
              : null,
        ),
        body: _screens[_selectedSection],
        bottomNavigationBar: NavigationBar(
          selectedIndex: _selectedSection,
          onDestinationSelected: (value) {
            setState(() => _selectedSection = value);
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.list_rounded),
              label: "Products",
            ),
            NavigationDestination(
              icon: Icon(Icons.bar_chart_rounded),
              label: "Statistics",
            ),
          ],
        ),
        floatingActionButton: const CartFAB(),
      ),
    );
  }
}

class _ProductSearchDelegate extends SearchDelegate {
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

    final result = mockProducts //
        .where((prod) => prod.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: result.length,
      itemBuilder: (context, index) => ProductListTile(
        product: result[index],
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final result = mockProducts //
        .where((prod) => prod.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: result.length,
      itemBuilder: (context, index) => ProductListTile(
        product: result[index],
      ),
    );
  }
}
