import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../enums/enums.dart';
import '../../../../secrets.dart';
import '../../../../shared/providers/appwrite_provider.dart';
import '../domain.dart';

final transactionService = Provider<TransactionService>((ref) {
  return TransactionService(ref.read);
});

class TransactionService {
  TransactionService(Reader read) : _db = read(dbProvider);

  final Database _db;

  Future<TransactionModel> addTransaction(TransactionModel transaction) async {
    final doc = await _db.createDocument(
      collectionId: Secrets.transactionCollectionId,
      documentId: "unique()",
      data: transaction.toJson(),
    );

    return transaction.copyWith(id: doc.$id);
  }

  Future<List<TransactionModel>> getTransactions({
    String? cursor,
    TransactionType? transactionType,
  }) async {
    final docs = await _db.listDocuments(
      collectionId: Secrets.transactionCollectionId,
      cursor: cursor,
      limit: 15,
      orderAttributes: ["timestamp"],
      orderTypes: ["DESC"],
      queries: transactionType != null
          ? [
              Query.equal(
                "transactionType",
                transactionType == TransactionType.buy ? "buy" : "sell",
              )
            ]
          : null,
    );

    return docs.documents
        .map((e) => TransactionModel.fromJson(e.data).copyWith(id: e.$id))
        .toList();
  }
}
