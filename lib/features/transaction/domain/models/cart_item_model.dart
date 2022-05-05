import 'package:equatable/equatable.dart';

import '../../../product/domain/domain.dart';

class CartItemModel extends Equatable {
  final ProductModel product;
  final double quantityInCart;

  const CartItemModel({
    required this.product,
    required this.quantityInCart,
  });

  @override
  List<Object?> get props => [product, quantityInCart];

  CartItemModel copyWith({
    ProductModel? product,
    double? quantityInCart,
  }) {
    return CartItemModel(
      product: product ?? this.product,
      quantityInCart: quantityInCart ?? this.quantityInCart,
    );
  }
}
