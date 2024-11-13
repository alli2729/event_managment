import 'package:flutter/material.dart';

class DateValues {
  DateValues._();

  static List<String> hoursDigit = [
    '00',
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
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
  ];
  static List<String> minutesDigit = [
    '0',
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
        '31',
    '32',
    '33',
    '34',
    '35',
    '36',
    '37',
    '38',
    '39',
    '40',
    '41',
    '42',
    '43',
    '44',
    '45',
    '46',
    '47',
    '48',
    '49',
    '50',
    '51',
    '52',
    '53',
    '54',
    '55',
    '56',
    '57',
    '58',
    '59',
  ];
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

  static List<DropdownMenuItem<String>> months = [
    const DropdownMenuItem(
      value: '01',
      child: Text('January'),
    ),
    const DropdownMenuItem(
      value: '02',
      child: Text('February'),
    ),
    const DropdownMenuItem(
      value: '03',
      child: Text('March'),
    ),
    const DropdownMenuItem(
      value: '04',
      child: Text('April'),
    ),
    const DropdownMenuItem(
      value: '05',
      child: Text('May'),
    ),
    const DropdownMenuItem(
      value: '06',
      child: Text('June'),
    ),
    const DropdownMenuItem(
      value: '07',
      child: Text('July'),
    ),
    const DropdownMenuItem(
      value: '08',
      child: Text('August'),
    ),
    const DropdownMenuItem(
      value: '09',
      child: Text('September'),
    ),
    const DropdownMenuItem(
      value: '10',
      child: Text('October'),
    ),
    const DropdownMenuItem(
      value: '11',
      child: Text('November'),
    ),
    const DropdownMenuItem(
      value: '12',
      child: Text('December'),
    ),
  ];

  static List<DropdownMenuItem<String>> years = yearsDigit.map(
    (String items) {
      return DropdownMenuItem(
        value: items,
        child: Text(items),
      );
    },
  ).toList();

  static List<DropdownMenuItem<String>> hours = hoursDigit.map(
    (String items) {
      return DropdownMenuItem(
        value: items,
        child: Text(items),
      );
    },
  ).toList();

  static List<DropdownMenuItem<String>> minutes = minutesDigit.map(
    (String items) {
      return DropdownMenuItem(
        value: (items.length == 1) ? '0$items' : items,
        child: Text(items),
      );
    },
  ).toList();
}
