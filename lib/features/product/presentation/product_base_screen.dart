import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../enums/enums.dart';
import '../../../shared/widgets/sort_button.dart';
import '../../category/domain/domain.dart';
import '../providers/category_provider.dart';
import '../widgets/product_list_section.dart';
import '../widgets/product_statistics_section.dart';

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
        categoryProductProvider.overrideWithValue(widget.category),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.category.name),
          actions: _selectedSection == 0
              ? [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.add_rounded),
                  ),
                  SortButton(
                    selectedSort: Sort.ascAlpha,
                    onSelected: (sort) {},
                  ),
                  IconButton(
                    onPressed: () {},
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
      ),
    );
  }
}
