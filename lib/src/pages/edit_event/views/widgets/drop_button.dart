import 'package:flutter/material.dart';

class DropButton extends StatelessWidget {
  const DropButton({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final String value;
  final List<DropdownMenuItem<String>> items;
  final void Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.black,
          style: BorderStyle.solid,
          width: 0.80,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          menuMaxHeight: 300,
          dropdownColor: const Color(0xFFEAF4F4),
          value: value,
          items: items,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
