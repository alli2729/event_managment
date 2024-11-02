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
          icon: const Icon(Icons.remove),
        ),
        const SizedBox(width: 12),
        Text('$_currentValue'),
        const SizedBox(width: 12),
        IconButton(
          onPressed: _increment,
          icon: const Icon(Icons.add),
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
