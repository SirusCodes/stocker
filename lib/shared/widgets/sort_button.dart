import 'package:flutter/material.dart';

import '../../enums/enums.dart';

class SortButton extends StatelessWidget {
  const SortButton({
    Key? key,
    required this.selectedSort,
    required this.onSelected,
  }) : super(key: key);

  final Sort selectedSort;
  final Function(Sort) onSelected;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Sort>(
      itemBuilder: (context) => [
        _buildPopupMenuItem(
          context,
          value: Sort.ascAlpha,
          icon: const Icon(Icons.keyboard_arrow_up_rounded),
          text: "Aplhabets",
        ),
        _buildPopupMenuItem(
          context,
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          text: "Aplhabets",
          value: Sort.dscAlpha,
        ),
      ],
      icon: const Icon(Icons.sort_rounded),
      initialValue: selectedSort,
      onSelected: onSelected,
    );
  }

  PopupMenuItem<Sort> _buildPopupMenuItem(
    BuildContext context, {
    required Icon icon,
    required String text,
    required Sort value,
  }) {
    return PopupMenuItem(
      value: value,
      child: IconTheme(
        data: Theme.of(context).iconTheme,
        child: Row(
          children: [
            icon,
            const SizedBox(width: 5),
            Text(text),
            if (selectedSort == value) ...[
              const Spacer(),
              const Icon(Icons.check_rounded)
            ]
          ],
        ),
      ),
    );
  }
}
