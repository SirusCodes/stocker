import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../enums/enums.dart';
import '../domain/domain.dart';
import '../domain/services/category_service.dart';

final categorySortProvider = StateProvider<Sort>((ref) {
  return Sort.ascAlpha;
});

final categoryProvider =
    StateNotifierProvider<CategoryProvider, AsyncValue<List<CategoryModel>>>(
  (ref) => CategoryProvider(ref.read, ref.watch(categorySortProvider)),
);

class CategoryProvider extends StateNotifier<AsyncValue<List<CategoryModel>>> {
  CategoryProvider(Reader read, Sort sort)
      : _service = read(categoryService),
        _sort = sort,
        super(const AsyncLoading()) {
    _getInitialCategories();
  }

  final CategoryService _service;

  bool _gettingMoreData = false;

  final Sort _sort;

  Future<void> _getInitialCategories() async {
    state =
        AsyncData(await _service.getAllCategories(order: _sort.getString()));
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
    final newCats = await _service.getAllCategories(
      cursor: oldData!.last.id,
      order: _sort.getString(),
    );

    oldData.addAll(newCats);

    state = AsyncData(oldData);
    _gettingMoreData = false;
  }
}
