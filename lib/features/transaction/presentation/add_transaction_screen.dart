import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../../utils/validators.dart';
import '../../customer/domain/models/customer_model.dart';
import '../../customer/domain/services/customer_service.dart';
import '../providers/cart_provider.dart';
import '../providers/transaction_provider.dart';
import '../widgets/show_cart_options_dialog.dart';

class AddTransactionScreen extends ConsumerWidget {
  const AddTransactionScreen({Key? key}) : super(key: key);

  static const path = "/transaction-screen";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems =
        ref.watch(cartProvider.select((value) => value.cartItems));

    ref
      ..listen<CartProvider>(
        cartProvider,
        (_, next) {
          if (next.cartItems.isEmpty) Navigator.pop(context);
        },
      )
      ..listen<TransactionState>(transactionProvider, (previous, next) {
        switch (next) {
          case TransactionState.success:
            ref.read(cartProvider).clear();
            Navigator.pop(context);
            Navigator.pop(context);
            break;
          case TransactionState.inProgress:
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => const Dialog(child: _LoadingDialog()),
            );
            break;
          case TransactionState.initial:
            break;
        }
      });

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text("Add Transaction"),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final item = cartItems[index];
                return ListTile(
                  title: Text(item.product.name),
                  subtitle: Text(
                    "Quantity: ${item.quantityInCart.toStringAsFixed(2)}",
                  ),
                  trailing: Text(
                    (item.product.sellingPrice * item.quantityInCart)
                        .toStringAsFixed(2),
                  ),
                  onTap: () =>
                      showCartOptionsDialog(context, product: item.product),
                );
              },
              childCount: cartItems.length,
            ),
          ),
          const SliverToBoxAdapter(
            child: _TransactionForm(),
          ),
        ],
      ),
    );
  }
}

class _TransactionForm extends ConsumerStatefulWidget {
  const _TransactionForm({Key? key}) : super(key: key);

  @override
  ConsumerState<_TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends ConsumerState<_TransactionForm> {
  final _formKey = GlobalKey<FormState>();

  final _phoneController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _discountController = TextEditingController();

  CustomerModel? _selectedCustomer;

  @override
  void initState() {
    super.initState();
    _discountController.addListener(_updateDiscount);
  }

  @override
  void dispose() {
    super.dispose();
    _discountController.removeListener(_updateDiscount);

    _phoneController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _discountController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _isPercentDiscount = ref.watch(cartProvider).isPercentDiscount;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TypeAheadFormField<CustomerModel>(
              validator: (value) {
                if (value == null || value.isEmpty) return "Enter number";
                if (int.parse(value) < 10) return "Check number";

                return null;
              },
              debounceDuration: const Duration(milliseconds: 500),
              textFieldConfiguration: TextFieldConfiguration(
                controller: _phoneController,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Phone number",
                  prefixText: "+91 ",
                  hintText: "9876543210",
                ),
              ),
              onSuggestionSelected: (customer) {
                _phoneController.text = customer.phone;
                _nameController.text = customer.name;
                _emailController.text = customer.email;
                _selectedCustomer = customer;
              },
              noItemsFoundBuilder: (_) {
                return ListTile(title: Text(_phoneController.text));
              },
              itemBuilder: (context, customer) {
                return ListTile(title: Text(customer.phone));
              },
              suggestionsCallback: (pattern) {
                return ref
                    .read(customerService)
                    .searchCustomerFromNumber(pattern);
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _nameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter customer name";
                }
                return null;
              },
              decoration: const InputDecoration(
                labelText: "Name",
                hintText: "Customer name",
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter customer email";
                }
                if (!Validators.isEmail(value)) {
                  return "Enter a valid email address";
                }

                return null;
              },
              decoration: const InputDecoration(
                labelText: "Email",
                hintText: "Customer email",
              ),
            ),
            const Divider(),
            TextFormField(
              controller: _discountController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              validator: (value) {
                if (value == null || value.isEmpty) return null;

                if (_isPercentDiscount && double.parse(value) >= 100) {
                  return "Cannot give 100% or more discount";
                }

                return null;
              },
              decoration: InputDecoration(
                labelText: "Discount (optional)",
                hintText: "10",
                prefixText: !_isPercentDiscount ? "₹ " : null,
                suffixIcon: IconButton(
                  onPressed: () => setState(() {
                    ref.read(cartProvider).isPercentDiscount =
                        !_isPercentDiscount;
                  }),
                  icon: _isPercentDiscount
                      ? const Icon(Icons.percent)
                      : const Icon(Icons.numbers_rounded),
                ),
              ),
            ),
            const Divider(),
            _buildSubtotalRow(),
            const SizedBox(height: 5),
            _buildDiscountRow(),
            const SizedBox(height: 5),
            _buildTotalRow(),
            const SizedBox(height: 10),
            SizedBox(
              width: double.maxFinite,
              child: AnimatedBuilder(
                animation: Listenable.merge([
                  _nameController,
                  _emailController,
                  _phoneController,
                ]),
                builder: (context, child) => ElevatedButton(
                  onPressed: _canContinue ? _onContinuePressed : null,
                  child: child,
                ),
                child: const Text("Confirm"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onContinuePressed() {
    if (!_formKey.currentState!.validate()) return;

    ref.read(transactionProvider.notifier).saveTransaction(
          customer: _selectedCustomer ??
              CustomerModel(
                name: _nameController.text,
                email: _emailController.text,
                phone: _phoneController.text,
              ),
          totalDiscount: double.tryParse(_discountController.text) ?? 0,
        );
  }

  bool get _canContinue =>
      _nameController.text.isNotEmpty &&
      _emailController.text.isNotEmpty &&
      Validators.isEmail(_emailController.text) &&
      _phoneController.text.isNotEmpty;

  void _updateDiscount() {
    ref.read(cartProvider).discount = _discountController.text;
  }

  Widget _buildSubtotalRow() {
    final subtotal = ref.read(cartProvider).subtotal;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [const Text("Subtotal"), Text("₹$subtotal")],
    );
  }

  Widget _buildDiscountRow() {
    final discount = ref.read(cartProvider).discount;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [const Text("Discount"), Text("-₹$discount")],
    );
  }

  Widget _buildTotalRow() {
    final total = ref.read(cartProvider).total;
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.bodyLarge!,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [const Text("Total"), Text("₹$total")],
      ),
    );
  }
}

class _LoadingDialog extends StatelessWidget {
  const _LoadingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          CircularProgressIndicator(),
          SizedBox(height: 10),
          Text("Saving your requests...")
        ],
      ),
    );
  }
}
