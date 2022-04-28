import 'package:flutter/material.dart';

import '../../extensions/extensions.dart';
import '../../features/product/domain/domain.dart';

class ProductListTile extends StatelessWidget {
  const ProductListTile({Key? key, required this.product}) : super(key: key);

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: product.color,
        child: FittedBox(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              product.name.avatarString,
              style: TextStyle(
                color: product.color.blackOrWhiteForForeground,
              ),
            ),
          ),
        ),
      ),
      title: Text(product.name),
      subtitle: Text("Quantity: ${product.quantity}"),
      onTap: () {},
    );
  }
}
