import 'package:flutter/material.dart';

class BuyCounter extends StatefulWidget {
  const BuyCounter({
    super.key,
    required this.maxValue,
    required this.minValue,
    required this.onChanged,
  });

  final int minValue;
  final int maxValue;
  final void Function(int) onChanged;

  @override
  State<BuyCounter> createState() => _BuyCounterState();
}

class _BuyCounterState extends State<BuyCounter> {
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
          onPressed: _decrement,
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        const SizedBox(width: 6),
        Text(
          '$_currentValue',
          style: const TextStyle(
            fontSize: 20,
            color: Color(0xFF2D5845),
          ),
        ),
        const SizedBox(width: 6),
        IconButton(
          onPressed: _increment,
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
