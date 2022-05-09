import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../enums/enums.dart';
import '../domain/models/transaction_model.dart';

final _mockTransactionHistory = [
  TransactionModel(
    customerId: "",
    productId: "productId",
    productName: "Prod",
    quantity: 10,
    sellingPrice: 15,
    costPrice: 20,
    transactionType: TransactionType.sell,
    timestamp: DateTime.now(),
  ),
  TransactionModel(
    customerId: "",
    productId: "productId",
    productName: "Prod",
    quantity: 10,
    sellingPrice: 0,
    costPrice: 20,
    transactionType: TransactionType.buy,
    timestamp: DateTime.now(),
  ),
  TransactionModel(
    customerId: "",
    productId: "productId",
    productName: "Prod",
    quantity: 10,
    sellingPrice: 50,
    costPrice: 20,
    transactionType: TransactionType.sell,
    timestamp: DateTime.now(),
  ),
];

class TransactionHistoryScreen extends StatelessWidget {
  const TransactionHistoryScreen({Key? key}) : super(key: key);

  static const String path = "/transaction-history";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transaction history"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.filter_alt_rounded),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _mockTransactionHistory.length,
        itemBuilder: (context, index) {
          final transaction = _mockTransactionHistory[index];

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
      ),
    );
  }

  String _getSubtitle(TransactionModel model) {
    final formattedDate = DateFormat("dd-MM-yy").format(model.timestamp);
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
}
