import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../enums/enums.dart';
import '../../product/domain/domain.dart';
import '../../product/providers/product_provider.dart';
import '../domain/domain.dart';
import '../domain/services/transaction_service.dart';

void showAddStockDialog(
  BuildContext context, {
  required ProductModel product,
}) {
  showDialog(
    context: context,
    builder: (_) => Dialog(
      child: _QuantityOption(product: product),
    ),
  );
}

class _QuantityOption extends StatefulWidget {
  const _QuantityOption({Key? key, required this.product}) : super(key: key);

  final ProductModel product;

  @override
  State<_QuantityOption> createState() => __QuantityOptionState();
}

class __QuantityOptionState extends State<_QuantityOption> {
  final _quantityController = TextEditingController();
  final _costPriceController = TextEditingController();
  final _sellingPriceController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _quantityController.dispose();
    _costPriceController.dispose();
    _sellingPriceController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.product.name,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _quantityController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              labelText: "Quantity",
              hintText: "1.5",
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _costPriceController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              labelText: "New cost price (optional)",
              hintText: "100",
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _sellingPriceController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              labelText: "New selling price (optional)",
              hintText: "120",
            ),
          ),
          const SizedBox(height: 10),
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: _quantityController,
            builder: (context, value, child) {
              final isEnabled = value.text.isNotEmpty;

              return Consumer(
                builder: (context, ref, child) {
                  return SizedBox(
                    width: double.maxFinite,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ElevatedButton(
                          onPressed:
                              isEnabled ? () => _addStock(ref.read) : null,
                          child: const Text("Add stock"),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> _addStock(Reader read) async {
    final quantity = double.parse(_quantityController.text);
    final costPrice = double.tryParse(_costPriceController.text);
    final sellingPrice = double.tryParse(_sellingPriceController.text);

    final product = widget.product;
    final transaction = TransactionModel(
      customerId: "",
      productId: product.id!,
      productName: product.name,
      quantity: quantity,
      sellingPrice: sellingPrice ?? product.sellingPrice,
      costPrice: costPrice ?? product.costPrice,
      transactionType: TransactionType.buy,
      timestamp: DateTime.now(),
    );

    await Future.wait([
      read(transactionService).addTransaction(transaction),
      read(productProvider(product.categoryId).notifier)
          .updateProduct(product.copyWith(
        quantity: product.quantity + quantity,
        costPrice: costPrice,
        sellingPrice: sellingPrice,
      ))
    ]);

    Navigator.pop(context);
  }
}
