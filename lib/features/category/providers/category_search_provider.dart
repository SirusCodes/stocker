import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/domain.dart';
import '../domain/services/category_service.dart';

final categorySearchProvider =
    StateNotifierProvider<CategorySearchProvider, List<CategoryModel>>(
  (ref) => CategorySearchProvider(ref.read),
);

class CategorySearchProvider extends StateNotifier<List<CategoryModel>> {
  CategorySearchProvider(Reader read)
      : _service = read(categoryService),
        super([]);

  final CategoryService _service;

  Future<void> getResult(String query) async {
    state = await _service.searchCategory(query);
  }
}
