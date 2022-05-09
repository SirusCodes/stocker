import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../enums/enums.dart';
import '../domain/domain.dart';
import '../domain/services/transaction_service.dart';

enum TransactionHistoryFilter { all, buy, sell }

final transactionHistoryFilterProvider =
    StateProvider<TransactionHistoryFilter>(
  (_) => TransactionHistoryFilter.all,
);

final transactionHistoryProvider = StateNotifierProvider<
    TransactionHistoryProvider, AsyncValue<List<TransactionModel>>>((ref) {
  final filter = ref.watch(transactionHistoryFilterProvider);
  final service = ref.read(transactionService);
  return TransactionHistoryProvider(service, filter);
});

class TransactionHistoryProvider
    extends StateNotifier<AsyncValue<List<TransactionModel>>> {
  TransactionHistoryProvider(
    TransactionService service,
    TransactionHistoryFilter filter,
  )   : _service = service,
        _filter = filter,
        super(const AsyncLoading()) {
    _getInitialTransactions();
  }

  final TransactionService _service;

  final TransactionHistoryFilter _filter;

  static const _transactionFilterToType = {
    TransactionHistoryFilter.all: null,
    TransactionHistoryFilter.buy: TransactionType.buy,
    TransactionHistoryFilter.sell: TransactionType.sell,
  };

  bool _gettingMore = false;

  Future<void> _getInitialTransactions() async {
    state = AsyncData(await _service.getTransactions(
      transactionType: _transactionFilterToType[_filter],
    ));
  }

  Future<void> getMoreTransactions() async {
    if (_gettingMore) return;

    _gettingMore = true;

    final oldData = state.value!;
    final newTxns = await _service.getTransactions(
      cursor: oldData.last.id!,
      transactionType: _transactionFilterToType[_filter],
    );

    state = AsyncData(oldData..addAll(newTxns));

    _gettingMore = false;
  }
}
