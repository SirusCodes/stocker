import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../extensions/extensions.dart';
import '../../transaction/domain/domain.dart';
import '../domain/models/statistics_model.dart';
import '../domain/services/statistics_service.dart';

class StatisticsProviderModel {
  final StatisticsModel salesInMonth, profitInMonth;

  StatisticsProviderModel({
    required this.salesInMonth,
    required this.profitInMonth,
  });
}

final statisticsProvider = StateNotifierProvider<StatisticsProvider,
    AsyncValue<StatisticsProviderModel>>((ref) {
  final service = ref.read(statisticsService);
  return StatisticsProvider(service);
});

class StatisticsProvider
    extends StateNotifier<AsyncValue<StatisticsProviderModel>> {
  StatisticsProvider(StatisticsService service) : super(const AsyncLoading()) {
    _getData(service);
  }

  Future<void> _getData(StatisticsService service) async {
    final endDate = DateTime.now();
    final startDate = endDate.subtract(const Duration(days: 30));
    final transactions = await service //
        .getDataFromRange(startDate: startDate, endDate: endDate);

    state = AsyncData(StatisticsProviderModel(
      salesInMonth: _calculateSales(transactions, startDate),
      profitInMonth: _calculateProfits(transactions, startDate),
    ));
  }

  StatisticsModel _calculateSales(
    List<TransactionModel> transactions,
    DateTime startTime,
  ) {
    final Map<DateTime, double> _buckets = {};
    for (final txn in transactions) {
      final date = txn.timestamp.stripTime;
      if (!_buckets.containsKey(date)) {
        _buckets[date] = txn.quantity;
      } else {
        _buckets[date] = txn.quantity + _buckets[date]!;
      }
    }

    return StatisticsModel.fromMapData(_buckets, startTime);
  }

  StatisticsModel _calculateProfits(
    List<TransactionModel> transactions,
    DateTime startTime,
  ) {
    final Map<DateTime, double> _buckets = {};
    for (final txn in transactions) {
      final date = txn.timestamp.stripTime;
      if (!_buckets.containsKey(date)) {
        _buckets[date] = (txn.sellingPrice - txn.costPrice);
      } else {
        _buckets[date] = (txn.sellingPrice - txn.costPrice) + _buckets[date]!;
      }
    }

    return StatisticsModel.fromMapData(_buckets, startTime);
  }
}
