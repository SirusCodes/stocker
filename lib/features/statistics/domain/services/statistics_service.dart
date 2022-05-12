import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../secrets.dart';
import '../../../../shared/providers/appwrite_provider.dart';
import '../../../transaction/domain/domain.dart';

final statisticsService = Provider<StatisticsService>((ref) {
  final db = ref.read(dbProvider);
  return StatisticsService(db);
});

class StatisticsService {
  StatisticsService(Database db) : _db = db;

  final Database _db;

  Future<List<TransactionModel>> getDataFromRange({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final List<TransactionModel> _transaction = [];

    String? cursor;

    while (true) {
      final docs = await _db.listDocuments(
        collectionId: Secrets.transactionCollectionId,
        cursor: cursor,
        limit: 100,
        orderAttributes: ["timestamp"],
        orderTypes: ["ASC"],
        queries: [
          Query.equal("transactionType", "sell"),
          Query.greaterEqual("timestamp", startDate.toIso8601String()),
          Query.lesserEqual("timestamp", endDate.toIso8601String()),
        ],
      );

      _transaction
          .addAll(docs.documents.map((e) => TransactionModel.fromJson(e.data)));

      if (_transaction.length >= docs.total) break;
    }

    return _transaction;
  }
}
