import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/domain.dart';
import '../domain/services/product_service.dart';

final productSearchProvider = StateNotifierProvider.family<
    ProductSearchProvider, List<ProductModel>, String>(
  (ref, categoryId) => ProductSearchProvider(ref.read, categoryId),
);

class ProductSearchProvider extends StateNotifier<List<ProductModel>> {
  ProductSearchProvider(Reader read, String categoryId)
      : _service = read(productService),
        _categoryId = categoryId,
        super([]);

  final ProductService _service;
  final String _categoryId;

  Future<void> getResult(String query) async {
    state = await _service.productSearch(categoryId: _categoryId, query: query);
  }
}
