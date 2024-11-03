import 'package:flutter/material.dart';

class DialogItem extends StatelessWidget {
  const DialogItem({
    super.key,
    required this.isActive,
    required this.onChanged,
    required this.title,
  });

  final void Function(bool?) onChanged;
  final bool isActive;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
          value: isActive,
          onChanged: onChanged,
          checkColor: const Color(0xFFEAF4F4),
          activeColor: const Color(0xFF2B4D3E),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: (isActive)
                ? const Color(0xFF2B4D3E)
                : Colors.black.withOpacity(0.5),
          ),
        ),
      ],
    );
  }
}
