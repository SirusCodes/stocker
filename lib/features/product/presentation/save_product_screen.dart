import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../domain/domain.dart';

class SaveProductScreenArguments extends Equatable {
  final ProductModel? product;
  final String categoryId;

  const SaveProductScreenArguments({
    this.product,
    required this.categoryId,
  });

  @override
  List<Object?> get props => [product, categoryId];
}

class SaveProductScreen extends StatefulWidget {
  const SaveProductScreen({
    Key? key,
    this.arguments,
  }) : super(key: key);

  final SaveProductScreenArguments? arguments;

  static const path = "/save-product";

  @override
  State<SaveProductScreen> createState() => _SaveProductScreenState();
}

class _SaveProductScreenState extends State<SaveProductScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _costPriceController;
  late final TextEditingController _sellingPriceController;
  late final TextEditingController _quantityController;

  late final ProductModel? _product;

  @override
  void initState() {
    super.initState();
    _product = widget.arguments?.product;

    _nameController = TextEditingController(text: _product?.name);
    _costPriceController = TextEditingController(
      text: _product?.costPrice.toString(),
    );
    _sellingPriceController = TextEditingController(
      text: _product?.sellingPrice.toString(),
    );
    _quantityController = TextEditingController(
      text: _product?.quantity.toString(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _costPriceController.dispose();
    _sellingPriceController.dispose();
    _quantityController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${_product == null ? "Add" : "Update"} Product"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Name",
                hintText: "Category name",
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _quantityController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp("[0-9.]"))
              ],
              decoration: const InputDecoration(
                labelText: "Quantity",
                hintText: "100",
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _costPriceController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp("[0-9.]"))
              ],
              decoration: const InputDecoration(
                labelText: "Cost Price",
                hintText: "1000",
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _sellingPriceController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp("[0-9.]"))
              ],
              decoration: const InputDecoration(
                labelText: "Selling Price",
                hintText: "1100",
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.maxFinite,
              child: AnimatedBuilder(
                animation: Listenable.merge([
                  _nameController,
                  _costPriceController,
                  _quantityController,
                  _sellingPriceController,
                ]),
                builder: (context, child) => ElevatedButton.icon(
                  onPressed: _canSave ? () {} : null,
                  icon: const Icon(Icons.check),
                  label: const Text("Save"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool get _canSave {
    final _name = _nameController.text;
    final _quantity = double.tryParse(_quantityController.text);
    final _costPrice = double.tryParse(_costPriceController.text);
    final _sellPrice = double.tryParse(_sellingPriceController.text);

    if (_name.isEmpty ||
        _quantityController.text.isEmpty ||
        _costPriceController.text.isEmpty ||
        _sellingPriceController.text.isEmpty) return false;

    final _isNameChanged = _name.isNotEmpty && _name != _product?.name;
    if (_isNameChanged) return true;

    final _isQuantityChanged =
        _quantity != null && _quantity >= 0 && _quantity != _product?.quantity;
    if (_isQuantityChanged) return true;

    final _isCostChanged = _costPrice != null &&
        _costPrice >= 0 &&
        _costPrice != _product?.costPrice;
    if (_isCostChanged) return true;

    final _sellChanged = _sellPrice != null &&
        _sellPrice >= 0 &&
        _sellPrice != _product?.sellingPrice;
    if (_sellChanged) return true;

    return false;
  }
}
