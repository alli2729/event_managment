import 'package:flutter/material.dart';

class DateValues {
  DateValues._();

  static List<String> daysDigit = [
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
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30'
  ];
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
    '2031',
    '2032',
    '2033',
    '2034',
    '2035',
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
