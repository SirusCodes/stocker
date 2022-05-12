import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../enums/enums.dart';
import '../../customer/domain/models/customer_model.dart';
import '../../customer/domain/services/customer_service.dart';
import '../../product/providers/product_provider.dart';
import '../domain/domain.dart';
import '../domain/services/transaction_service.dart';
import 'cart_provider.dart';

enum TransactionState { success, inProgress, initial }

final transactionProvider =
    StateNotifierProvider<TransactionProvider, TransactionState>((ref) {
  return TransactionProvider(ref.read);
});

class TransactionProvider extends StateNotifier<TransactionState> {
  TransactionProvider(this.read) : super(TransactionState.initial);

  final Reader read;

  Future<void> saveTransaction({
    required CustomerModel customer,
    required double totalDiscount,
  }) async {
    state = TransactionState.inProgress;
    String _customerId;
    if (customer.id == null) {
      _customerId = (await read(customerService).addCustomer(customer)).id!;
    } else {
      _customerId = customer.id!;
    }

    final cartItems = read(cartProvider).cartItems;

    final totalItemsSold = cartItems.fold<double>(
      0,
      (previousValue, item) => previousValue + item.quantityInCart,
    );

    final discountPerProd = totalDiscount / totalItemsSold;

    for (final item in cartItems) {
      final product = item.product;
      final transaction = TransactionModel(
        customerId: _customerId,
        productId: product.id!,
        productName: product.name,
        quantity: item.quantityInCart,
        sellingPrice:
            product.sellingPrice - (item.quantityInCart * discountPerProd),
        costPrice: product.costPrice,
        transactionType: TransactionType.sell,
        timestamp: DateTime.now(),
      );

      await Future.wait([
        read(transactionService).addTransaction(transaction),
        read(productProvider(product.categoryId).notifier)
            .updateProduct(product.copyWith(
          quantity: product.quantity - item.quantityInCart,
        )),
      ]);
    }

    state = TransactionState.success;
  }
}
