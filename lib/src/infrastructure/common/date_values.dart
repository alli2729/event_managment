import 'package:flutter/material.dart';

class DateValues {
  DateValues._();

  static List<String> daysDigit = ['1', '2', '3', '4', '5', '6'];
  static List<String> monthsDigit = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
  ];
  static List<String> yearsDigit = [
    '2022',
    '2023',
    '2024',
    '2025',
    '2026',
    '2028',
    '2029',
    '2030',
  ];

  static List<DropdownMenuItem<String>> days = daysDigit.map(
    (String items) {
      return DropdownMenuItem(
        value: (items.length == 1) ? '0$items' : items,
        child: Text(items),
      );
    },
  ).toList();

  static List<DropdownMenuItem<String>> months = monthsDigit.map(
    (String items) {
      return DropdownMenuItem(
        value: (items.length == 1) ? '0$items' : items,
        child: Text(items),
      );
    },
  ).toList();

  static List<DropdownMenuItem<String>> years = yearsDigit.map(
    (String items) {
      return DropdownMenuItem(
        value: items,
        child: Text(items),
      );
    },
  ).toList();
}
