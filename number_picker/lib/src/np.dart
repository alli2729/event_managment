import 'package:flutter/material.dart';
export './np.dart';

class NumberPicker extends StatefulWidget {
  const NumberPicker({
    super.key,
    required this.maxValue,
    required this.minValue,
    required this.onChanged,
    required this.numberColor,
  });

  final int minValue;
  final int maxValue;
  final void Function(int) onChanged;
  final Color? numberColor;

  @override
  State<NumberPicker> createState() => _NumberPickerState();
}

class _NumberPickerState extends State<NumberPicker> {
  late int _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.minValue;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: (_currentValue == widget.minValue) ? null : _decrement,
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        const SizedBox(width: 6),
        Text(
          '$_currentValue',
          style: TextStyle(
            fontSize: 20,
            color: widget.numberColor ?? Colors.black,
          ),
        ),
        const SizedBox(width: 6),
        IconButton(
          onPressed: (_currentValue == widget.maxValue) ? null : _increment,
          icon: const Icon(Icons.arrow_forward_ios),
        ),
      ],
    );
  }

  void _increment() {
    setState(() {
      if (_currentValue < widget.maxValue) {
        _currentValue++;
        widget.onChanged(_currentValue);
      }
    });
  }

  void _decrement() {
    setState(() {
      if (_currentValue > widget.minValue) {
        _currentValue--;
        widget.onChanged(_currentValue);
      }
    });
  }
}
