import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/domain.dart';
import '../domain/services/category_service.dart';

final categoryProvider =
    StateNotifierProvider<CategoryProvider, AsyncValue<List<CategoryModel>>>(
        (ref) {
  return CategoryProvider(ref.read);
});

class CategoryProvider extends StateNotifier<AsyncValue<List<CategoryModel>>> {
  CategoryProvider(Reader read)
      : _service = read(categoryService),
        super(const AsyncLoading()) {
    _getInitialCategories();
  }

  final CategoryService _service;

  bool _gettingMoreData = false;

  Future<void> _getInitialCategories() async {
    state = AsyncData(await _service.getAllCategories());
  }

  Future<void> createCategory(CategoryModel category) async {
    final oldData = state.value;
    state = const AsyncLoading();
    final newCat = await _service.createCategory(category);

    state = AsyncData([...oldData!, newCat]);
  }

  Future<void> updateCategory(CategoryModel category) async {
    final oldData = state.value;
    state = const AsyncLoading();
    final newCat = await _service.updateCategory(category);

    final index = oldData!.indexWhere((element) => element.id == newCat.id);
    oldData[index] = newCat;

    state = AsyncData(oldData);
  }

  Future<void> getMoreCategories() async {
    if (_gettingMoreData) return;

    _gettingMoreData = true;
    final oldData = state.value;
    final newCats = await _service.getAllCategories(oldData!.last.id);

    oldData.addAll(newCats);

    state = AsyncData(oldData);
    _gettingMoreData = false;
  }
}
