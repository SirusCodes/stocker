import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../enums/enums.dart';
import '../../extensions/extensions.dart';
import '../../features/product/domain/domain.dart';
import '../../features/product/presentation/save_product_screen.dart';
import '../../features/product/providers/product_provider.dart';
import '../../features/transaction/widgets/show_add_stock_dialog.dart';
import '../../features/transaction/widgets/show_cart_options_dialog.dart';

class ProductListTile extends ConsumerWidget {
  const ProductListTile({Key? key, required this.product}) : super(key: key);

  final ProductModel product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
      subtitle: Text(
        "Quantity: ${product.quantity}\nPrice: ${product.sellingPrice}",
      ),
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
                  categoryColor: product.color,
                  product: product,
                ),
              );
              break;
            case ListMenu.delete:
              ref
                  .read(productProvider(product.categoryId).notifier)
                  .deleteProduct(product);
              break;
            case ListMenu.addStock:
              showAddStockDialog(context, product: product);
              break;
          }
        },
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: ListMenu.edit,
            child: Text("Edit"),
          ),
          const PopupMenuItem(
            value: ListMenu.addStock,
            child: Text("Add Stock"),
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
      onTap: () => showCartOptionsDialog(context, product: product),
    );
  }
}
