import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../enums/enums.dart';
import '../domain/models/transaction_model.dart';
import '../providers/transaction_history_provider.dart';

class TransactionHistoryScreen extends ConsumerStatefulWidget {
  const TransactionHistoryScreen({Key? key}) : super(key: key);

  static const String path = "/transaction-history";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState
    extends ConsumerState<TransactionHistoryScreen> {
  final _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_loadMore);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController
      ..removeListener(_loadMore)
      ..dispose();
  }

  void _loadMore() {
    if (_scrollController.position.extentAfter < 50) {
      ref.read(transactionHistoryProvider.notifier).getMoreTransactions();
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedFilter = ref.watch(transactionHistoryFilterProvider);
    final transactions = ref.watch(transactionHistoryProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transaction history"),
        actions: [
          PopupMenuButton<TransactionHistoryFilter>(
            itemBuilder: (context) => [
              _buildFilterOption(
                context,
                selectedValue: selectedFilter,
                value: TransactionHistoryFilter.all,
                icon: const Icon(Icons.swap_vertical_circle_outlined),
                text: "All",
              ),
              _buildFilterOption(
                context,
                selectedValue: selectedFilter,
                value: TransactionHistoryFilter.buy,
                icon: const Icon(Icons.arrow_circle_down_rounded),
                text: "Buy",
              ),
              _buildFilterOption(
                context,
                selectedValue: selectedFilter,
                value: TransactionHistoryFilter.sell,
                icon: const Icon(Icons.arrow_circle_up_rounded),
                text: "Sell",
              )
            ],
            icon: const Icon(Icons.filter_alt_rounded),
            onSelected: (value) {
              ref.read(transactionHistoryFilterProvider.notifier).state = value;
            },
          ),
        ],
      ),
      body: transactions.when(
        data: (txns) {
          return ListView.builder(
            controller: _scrollController,
            itemCount: txns.length,
            itemBuilder: (context, index) {
              final transaction = txns[index];

              return ListTile(
                leading: transaction.transactionType == TransactionType.sell
                    ? const Icon(
                        Icons.arrow_circle_up_rounded,
                        color: Colors.green,
                      )
                    : const Icon(
                        Icons.arrow_circle_down_rounded,
                        color: Colors.red,
                      ),
                title: Text(transaction.productName),
                subtitle: Text(_getSubtitle(transaction)),
                isThreeLine: true,
              );
            },
          );
        },
        error: (_, __) => const Center(child: Text("Something went wrong...")),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  String _getSubtitle(TransactionModel model) {
    final formattedDate =
        DateFormat("dd-MM-yyyy").add_jm().format(model.timestamp);
    if (model.transactionType == TransactionType.buy) {
      return """Total cost price - ${model.costPrice.toStringAsFixed(2)} x ${model.quantity.toStringAsFixed(2)} = ${(model.costPrice * model.quantity).toStringAsFixed(2)}
Date - $formattedDate""";
    }

    return """Net profit - ${_getNetProfit(model).toStringAsFixed(2)} x ${model.quantity.toStringAsFixed(2)} = ${(_getNetProfit(model) * model.quantity).toStringAsFixed(2)}
Date - $formattedDate
Selling price - ${model.sellingPrice}""";
  }

  double _getNetProfit(TransactionModel model) {
    return model.sellingPrice - model.costPrice;
  }

  PopupMenuItem<TransactionHistoryFilter> _buildFilterOption(
    BuildContext context, {
    required TransactionHistoryFilter selectedValue,
    required TransactionHistoryFilter value,
    required Widget icon,
    required String text,
  }) {
    return PopupMenuItem<TransactionHistoryFilter>(
      value: value,
      child: IconTheme(
        data: Theme.of(context).iconTheme,
        child: Row(
          children: [
            icon,
            const SizedBox(width: 5),
            Text(text),
            if (selectedValue == value) ...[
              const Spacer(),
              const Icon(Icons.check_rounded)
            ]
          ],
        ),
      ),
    );
  }
}
