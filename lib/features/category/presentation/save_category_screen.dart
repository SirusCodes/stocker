import 'dart:math';

import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';

import '../domain/domain.dart';

class SaveCategoryScreen extends StatefulWidget {
  const SaveCategoryScreen({Key? key, this.category}) : super(key: key);

  final CategoryModel? category;

  static const path = "/save-category";

  @override
  State<SaveCategoryScreen> createState() => _SaveCategoryScreenState();
}

class _SaveCategoryScreenState extends State<SaveCategoryScreen> {
  late final TextEditingController _nameController;
  late Color _categoryColor;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.category?.name);
    _categoryColor = widget.category?.color ?? _randomColor;
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.category == null ? "Add" : "Update"} Category"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Name",
                hintText: "Category name",
              ),
            ),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: _categoryColor,
            ),
            title: const Text("Assign color for category (optional)"),
            subtitle: Text(
              "Current color: ${ColorTools.nameThatColor(_categoryColor)}",
            ),
            onTap: _showColorPicker,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              width: double.maxFinite,
              child: ValueListenableBuilder<TextEditingValue>(
                valueListenable: _nameController,
                builder: (context, value, child) => ElevatedButton.icon(
                  onPressed: _canSave(value.text) ? () {} : null,
                  icon: const Icon(Icons.check),
                  label: const Text("Save"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _canSave(String value) =>
      (value.isNotEmpty && value != widget.category?.name) ||
      (widget.category?.color != null &&
          _categoryColor != widget.category!.color);

  Future<bool> _showColorPicker() {
    return ColorPicker(
      color: _categoryColor,
      onColorChanged: (Color color) => setState(() => _categoryColor = color),
      width: 40,
      height: 40,
      borderRadius: 4,
      spacing: 5,
      runSpacing: 5,
      heading: Text(
        'Select color',
        style: Theme.of(context).textTheme.subtitle1,
      ),
      subheading: Text(
        'Select color shade',
        style: Theme.of(context).textTheme.subtitle1,
      ),
      materialNameTextStyle: Theme.of(context).textTheme.caption,
      colorNameTextStyle: Theme.of(context).textTheme.caption,
      colorCodeTextStyle: Theme.of(context).textTheme.caption,
      pickersEnabled: const <ColorPickerType, bool>{
        ColorPickerType.primary: true,
        ColorPickerType.accent: false,
      },
    ).showPickerDialog(
      context,
      constraints:
          const BoxConstraints(minHeight: 350, minWidth: 300, maxWidth: 320),
    );
  }

  Color get _randomColor =>
      Colors.primaries[Random().nextInt(Colors.primaries.length)];
}
