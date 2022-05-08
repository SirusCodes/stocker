import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/widgets/product_list_tile.dart';
import '../providers/product_category_provider.dart';
import '../providers/product_provider.dart';

class ProductListSection extends ConsumerStatefulWidget {
  const ProductListSection({Key? key}) : super(key: key);

  @override
  ConsumerState<ProductListSection> createState() => _ProductListSectionState();
}

class _ProductListSectionState extends ConsumerState<ProductListSection> {
  final _scrollController = ScrollController();
  late final String _categoryId;

  @override
  void initState() {
    super.initState();
    _categoryId = ref.read(productCategoryProvider).id!;
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
      ref.read(productProvider(_categoryId).notifier).getMoreProducts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(productProvider(_categoryId)).when(
          data: (products) {
            return ListView.builder(
              controller: _scrollController,
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];

                return ProductListTile(product: product);
              },
            );
          },
          error: (_, __) {
            return const Center(child: Text("Something when wrong..."));
          },
          loading: () => const Center(child: CircularProgressIndicator()),
        );
  }
}
