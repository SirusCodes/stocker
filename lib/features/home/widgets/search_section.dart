import 'package:flutter/material.dart';

import '../../../shared_widgets/product_list_tile.dart';
import '../../product/domain/domain.dart';

const _mockProducts = [
  ProductModel(
    name: "Product A",
    costPrice: 10,
    sellingPrice: 20,
    quantity: 50,
    color: Colors.amber,
  ),
  ProductModel(
    name: "Product B",
    costPrice: 10,
    sellingPrice: 20,
    quantity: 5,
    color: Colors.black12,
  ),
  ProductModel(
    name: "Product C",
    costPrice: 10,
    sellingPrice: 20,
    quantity: 10,
    color: Colors.deepPurpleAccent,
  ),
];

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
        itemCount: _mockProducts.length,
        itemBuilder: (context, index) {
          final product = _mockProducts[index];
          return ProductListTile(product: product);
        },
      ),
    );
  }
}
