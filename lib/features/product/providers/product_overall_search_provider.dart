import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/domain.dart';
import '../domain/services/product_service.dart';

final productOverallSearchProvider =
    StateNotifierProvider<ProductSearchProvider, List<ProductModel>>(
  (ref) => ProductSearchProvider(ref.read),
);

class ProductSearchProvider extends StateNotifier<List<ProductModel>> {
  ProductSearchProvider(Reader read)
      : _service = read(productService),
        super([]);

  final ProductService _service;

  Future<void> getResult(String query) async {
    state = await _service.overallSearch(query);
  }
}
