import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../secrets.dart';
import '../../../../shared/providers/appwrite_provider.dart';
import '../domain.dart';

final productService = Provider<ProductService>((ref) {
  return ProductService(ref.read);
});

class ProductService {
  ProductService(Reader read) : _db = read(dbProvider);

  final Database _db;

  Future<ProductModel> createProduct(ProductModel product) async {
    final doc = await _db.createDocument(
      collectionId: Secrets.productCollectionId,
      documentId: "unique()",
      data: product.toJson(),
    );

    return product.copyWith(id: doc.$id);
  }

  Future<ProductModel> updateProduct(ProductModel product) async {
    await _db.updateDocument(
      collectionId: Secrets.productCollectionId,
      documentId: product.id!,
      data: product.toJson(),
    );

    return product;
  }

  Future<void> deleteProduct(String productId) {
    return _db.deleteDocument(
      collectionId: Secrets.productCollectionId,
      documentId: productId,
    );
  }

  Future<List<ProductModel>> getProducts({
    required String categoryId,
    String? cursor,
    String order = "ASC",
  }) async {
    final docs = await _db.listDocuments(
      collectionId: Secrets.productCollectionId,
      limit: 10,
      cursor: cursor,
      orderAttributes: ["name"],
      orderTypes: [order],
      queries: [Query.equal("categoryId", categoryId)],
    );

    return docs.documents
        .map((e) => ProductModel.fromJson(e.data).copyWith(id: e.$id))
        .toList();
  }

  Future<List<ProductModel>> productSearch({
    required String categoryId,
    required String query,
  }) async {
    final docs = await _db.listDocuments(
      collectionId: Secrets.productCollectionId,
      limit: 8,
      queries: [
        Query.equal("categoryId", categoryId),
        Query.search("name", query),
      ],
    );

    return docs.documents
        .map((e) => ProductModel.fromJson(e.data).copyWith(id: e.$id))
        .toList();
  }

  Future<List<ProductModel>> overallSearch(String query) async {
    final docs = await _db.listDocuments(
      collectionId: Secrets.productCollectionId,
      limit: 8,
      queries: [Query.search("name", query)],
    );

    return docs.documents
        .map((e) => ProductModel.fromJson(e.data).copyWith(id: e.$id))
        .toList();
  }
}
