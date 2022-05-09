import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/widgets/product_list_tile.dart';
import '../../product/providers/product_overall_search_provider.dart';

class SearchSection extends ConsumerStatefulWidget {
  const SearchSection({Key? key}) : super(key: key);

  @override
  ConsumerState<SearchSection> createState() => _SearchSectionState();
}

class _SearchSectionState extends ConsumerState<SearchSection> {
  Timer? _debounce;

  @override
  void dispose() {
    super.dispose();
    _debounce?.cancel();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      ref.read(productOverallSearchProvider.notifier).getResult(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    final results = ref.watch(productOverallSearchProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        title: TextField(
          onChanged: _onSearchChanged,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "Search products",
            prefixIcon: Icon(Icons.search_rounded),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, index) {
          final product = results[index];
          return ProductListTile(product: product);
        },
      ),
    );
  }
}
