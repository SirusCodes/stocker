import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../presentation/add_transaction_screen.dart';
import '../providers/cart_provider.dart';

class CartFAB extends ConsumerWidget {
  const CartFAB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider.select((value) => value.cartItems));
    if (cart.isEmpty) return const SizedBox.shrink();

    return FloatingActionButton(
      onPressed: () => Navigator.pushNamed(context, AddTransactionScreen.path),
      child: Badge(
        badgeContent: Text(
          cart.length.toString(),
          style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 10),
        ),
        badgeColor: Theme.of(context).colorScheme.onSecondary,
        child: const Icon(Icons.shopping_cart_rounded),
      ),
    );
  }
}
