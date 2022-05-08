import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/providers/appwrite_provider.dart';

import '../domain.dart';

final categoryService = Provider<CategoryService>((ref) {
  return CategoryService(ref.read);
});

class CategoryService {
  CategoryService(Reader read) : _db = read(dbProvider);
  final Database _db;

  static const _categoryId = "6277b82c8325e59d9529";

  Future<CategoryModel> createCategory(CategoryModel category) async {
    final doc = await _db.createDocument(
      collectionId: _categoryId,
      documentId: "unique()",
      data: category.toJson(),
    );

    return CategoryModel.fromJson(doc.data).copyWith(id: doc.$id);
  }

  Future<List<CategoryModel>> getAllCategories({
    String? cursor,
    String order = "ASC",
  }) async {
    final docs = await _db.listDocuments(
      collectionId: _categoryId,
      limit: 10,
      cursor: cursor,
      orderAttributes: ["name"],
      orderTypes: [order],
    );

    return docs.documents
        .map((e) => CategoryModel.fromJson(e.data).copyWith(id: e.$id))
        .toList();
  }

  Future<CategoryModel> updateCategory(CategoryModel category) async {
    await _db.updateDocument(
      collectionId: _categoryId,
      documentId: category.id!,
      data: category.toJson(),
    );

    return category;
  }

  Future<List<CategoryModel>> searchCategory(String query) async {
    final docs = await _db.listDocuments(
      collectionId: _categoryId,
      limit: 8,
      queries: [Query.search("name", query)],
    );

    return docs.documents
        .map((e) => CategoryModel.fromJson(e.data).copyWith(id: e.$id))
        .toList();
  }
}
