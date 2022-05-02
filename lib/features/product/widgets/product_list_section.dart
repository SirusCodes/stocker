import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/widgets/product_list_tile.dart';

class ProductListSection extends ConsumerWidget {
  const ProductListSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      itemCount: mockProducts.length,
      itemBuilder: (context, index) {
        final product = mockProducts[index];

        return ProductListTile(product: product);
      },
    );
  }
}
