import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../enums/enums.dart';
import '../domain/domain.dart';
import '../domain/services/product_service.dart';

final productSortProvider = StateProvider<Sort>((ref) {
  return Sort.ascAlpha;
});

final productProvider = StateNotifierProvider.family<ProductProvider,
    AsyncValue<List<ProductModel>>, String>(
  (ref, categoryId) => ProductProvider(
    read: ref.read,
    sort: ref.watch(productSortProvider),
    categoryId: categoryId,
  ),
);

class ProductProvider extends StateNotifier<AsyncValue<List<ProductModel>>> {
  ProductProvider({
    required Reader read,
    required Sort sort,
    required String categoryId,
  })  : _prodService = read(productService),
        _categoryId = categoryId,
        _sort = sort,
        super(const AsyncLoading()) {
    _getInitialProducts();
  }

  final ProductService _prodService;
  final String _categoryId;
  final Sort _sort;
  bool _gettingMoreData = false;

  Future<void> _getInitialProducts() async {
    state = AsyncData(await _prodService.getProducts(
      order: _sort.getString(),
      categoryId: _categoryId,
    ));
  }

  Future<void> createProduct(ProductModel product) async {
    final oldData = state.value;
    state = const AsyncLoading();
    final newProd = await _prodService.createProduct(product);

    state = AsyncData([...oldData!, newProd]);
  }

  Future<void> updateProduct(ProductModel product) async {
    final oldData = state.value;
    state = const AsyncLoading();
    final newProd = await _prodService.updateProduct(product);

    final index = oldData!.indexWhere((element) => element.id == newProd.id);
    oldData[index] = newProd;

    state = AsyncData(oldData);
  }

  Future<void> getMoreProducts() async {
    if (_gettingMoreData) return;

    _gettingMoreData = true;
    final oldData = state.value;
    final newProds = await _prodService.getProducts(
      cursor: oldData!.last.id,
      categoryId: _categoryId,
      order: _sort.getString(),
    );

    oldData.addAll(newProds);

    state = AsyncData(oldData);
    _gettingMoreData = false;
  }

  void deleteProduct(ProductModel product) async {
    await _prodService.deleteProduct(product.id!);
    state = AsyncData(state.value!..remove(product));
  }
}
