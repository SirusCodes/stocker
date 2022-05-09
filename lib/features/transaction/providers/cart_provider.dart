import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/domain.dart';

final cartProvider = ChangeNotifierProvider<CartProvider>(
  (ref) => CartProvider(),
);

class CartProvider extends ChangeNotifier {
  String get subtotal => _subtotal.toStringAsFixed(2);
  String get total => _total.roundToDouble().toStringAsFixed(2);
  String get discount => _calculateDiscount.toStringAsFixed(2);
  bool get isPercentDiscount => _isPercentDiscount;
  List<CartItemModel> get cartItems => _cartItems.values.toList();

  set isPercentDiscount(bool value) {
    _isPercentDiscount = value;
    _calculateTotal();
  }

  set discount(String value) {
    _discount = double.parse(value);
    _calculateTotal();
  }

  void clear() {
    _cartItems.clear();
    _subtotal = 0;
    _discount = 0;
    _total = 0;
    _isPercentDiscount = true;
    notifyListeners();
  }

  //
  // Cart
  //
  final Map<String, CartItemModel> _cartItems = {};

  void addToCart(CartItemModel cartItem) {
    _cartItems[cartItem.product.id!] = cartItem;
    _calculateTotal();
  }

  void removeFromCart(String productId) {
    if (!_cartItems.containsKey(productId)) return;

    _cartItems.remove(productId);
    _calculateTotal();
  }

  void updateQuantity({
    required String productId,
    required double quantity,
  }) {
    if (!_cartItems.containsKey(productId)) return;

    _cartItems[productId] = _cartItems[productId]!.copyWith(
      quantityInCart: quantity,
    );
    _calculateTotal();
  }

  CartItemModel? getCartItem(String productId) => _cartItems[productId];

  //
  // Billing
  //
  double _subtotal = 0, _total = 0, _discount = 0;
  bool _isPercentDiscount = true;

  void _calculateTotal() {
    _subtotal = 0;
    for (final item in cartItems) {
      _subtotal += item.product.sellingPrice * item.quantityInCart;
    }

    _total = _subtotal - _calculateDiscount;
    notifyListeners();
  }

  double get _calculateDiscount {
    if (_isPercentDiscount) {
      return (_subtotal * _discount) / 100;
    }
    return _discount;
  }
}
