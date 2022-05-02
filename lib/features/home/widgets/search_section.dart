import 'package:flutter/material.dart';

import '../../../shared/widgets/product_list_tile.dart';

class SearchSection extends StatelessWidget {
  const SearchSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        title: const TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Search products",
            prefixIcon: Icon(Icons.search_rounded),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: mockProducts.length,
        itemBuilder: (context, index) {
          final product = mockProducts[index];
          return ProductListTile(product: product);
        },
      ),
    );
  }
}
