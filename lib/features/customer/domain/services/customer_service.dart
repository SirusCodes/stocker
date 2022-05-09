import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/providers/appwrite_provider.dart';
import '../models/customer_model.dart';

final customerService = Provider<CustomerService>((ref) {
  return CustomerService(ref.read);
});

class CustomerService {
  CustomerService(Reader read) : _db = read(dbProvider);

  final Database _db;

  static const _collectionId = "6279092297a0ef94c695";

  Future<List<CustomerModel>> searchCustomerFromNumber(String query) async {
    final docs = await _db.listDocuments(
      collectionId: _collectionId,
      limit: 5,
      queries: [Query.search("phone", query)],
    );

    return docs.documents
        .map((e) => CustomerModel.fromJson(e.data).copyWith(id: e.$id))
        .toList();
  }

  Future<CustomerModel> addCustomer(CustomerModel customer) async {
    final doc = await _db.createDocument(
      collectionId: _collectionId,
      documentId: "unique()",
      data: customer.toJson(),
    );

    return customer.copyWith(id: doc.$id);
  }
}
