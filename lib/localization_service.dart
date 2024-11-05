import 'package:flutter/material.dart';
import 'generated/locales.g.dart';

class LocalizationService {
  LocalizationService._();

  static const Map<String, Map<String, String>> keys = {
    'fa': {
      ...Locales.fa_IR,
    },
    'en': {
      ...Locales.en_US,
    },
  };

  static const defaultLocale = Locale('en', 'US');
}
