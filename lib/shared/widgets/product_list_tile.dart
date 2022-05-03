import 'package:flutter/material.dart';

import '../../enums/enums.dart';
import '../../extensions/extensions.dart';
import '../../features/product/domain/domain.dart';
import '../../features/product/presentation/save_product_screen.dart';

const mockProducts = [
  ProductModel(
    categoryId: "cat",
    name: "Product A",
    costPrice: 10,
    sellingPrice: 20,
    quantity: 50,
    color: Colors.amber,
  ),
  ProductModel(
    categoryId: "cat",
    name: "Product B",
    costPrice: 10,
    sellingPrice: 20,
    quantity: 5,
    color: Colors.black12,
  ),
  ProductModel(
    categoryId: "cat",
    name: "Product C",
    costPrice: 10,
    sellingPrice: 20,
    quantity: 10,
    color: Colors.deepPurpleAccent,
  ),
];

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
                color: product.color!.blackOrWhiteForForeground,
              ),
            ),
          ),
        ),
      ),
      title: Text(product.name),
      subtitle: Text("Quantity: ${product.quantity}"),
      trailing: PopupMenuButton<ListMenu>(
        tooltip: "Category menu",
        onSelected: (value) {
          switch (value) {
            case ListMenu.edit:
              Navigator.pushNamed(
                context,
                SaveProductScreen.path,
                arguments: SaveProductScreenArguments(
                  categoryId: product.categoryId,
                  product: product,
                ),
              );
              break;
            case ListMenu.delete:
              // TODO: Handle delete case
              break;
          }
        },
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: ListMenu.edit,
            child: Text("Edit"),
          ),
          PopupMenuItem(
            value: ListMenu.delete,
            child: Text(
              "Delete",
              style: TextStyle(color: Colors.red.shade400),
            ),
          ),
        ],
      ),
      onTap: () {},
    );
  }
}
