import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../product/domain/domain.dart';
import '../domain/domain.dart';
import '../presentation/add_transaction_screen.dart';
import '../providers/cart_provider.dart';

void showCartOptionsDialog(
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

  @override
  void dispose() {
    super.dispose();
    _quantityController.dispose();
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
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: _quantityController,
            builder: (context, value, child) {
              final isEnabled = value.text.isNotEmpty;

              return Consumer(
                builder: (context, ref, child) {
                  final cartPro = ref.read(cartProvider);
                  return SizedBox(
                    width: double.maxFinite,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (cartPro.getCartItem(widget.product.id!) != null)
                          ElevatedButton(
                            onPressed: isEnabled
                                ? () {
                                    final quantity =
                                        double.parse(_quantityController.text);
                                    if (quantity == 0) {
                                      cartPro
                                          .removeFromCart(widget.product.id!);
                                    } else {
                                      cartPro.updateQuantity(
                                        productId: widget.product.id!,
                                        quantity: quantity,
                                      );
                                    }

                                    Navigator.pop(context);
                                  }
                                : null,
                            child: const Text("Update quantity"),
                          ),
                        if (cartPro.getCartItem(widget.product.id!) == null)
                          ElevatedButton(
                            onPressed: isEnabled
                                ? () {
                                    final quantity =
                                        double.parse(_quantityController.text);
                                    cartPro.addToCart(CartItemModel(
                                      product: widget.product,
                                      quantityInCart: quantity,
                                    ));

                                    Navigator.pop(context);
                                  }
                                : null,
                            child: const Text("Add to cart"),
                          ),
                        if (cartPro.cartItems.isEmpty) ...[
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: isEnabled
                                ? () {
                                    final quantity =
                                        double.parse(_quantityController.text);
                                    cartPro.addToCart(CartItemModel(
                                      product: widget.product,
                                      quantityInCart: quantity,
                                    ));

                                    Navigator.popAndPushNamed(
                                      context,
                                      AddTransactionScreen.path,
                                    );
                                  }
                                : null,
                            child: const Text("Buy"),
                          ),
                        ]
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
}
