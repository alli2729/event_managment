import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'generated/locales.g.dart';

class LocalizationService {
  LocalizationService._();
  static final _box = GetStorage();

  static const Map<String, Map<String, String>> keys = {
    'fa': {
      ...Locales.fa_IR,
    },
    'en': {
      ...Locales.en_US,
    },
  };

  static const defaultLocale = Locale('en', 'US');

  static void changeLang() async {
    if (Get.locale == const Locale('en', 'US')) {
      await Get.updateLocale(const Locale('fa', 'IR'));
      await _box.write('lang_conde', 'fa');
      await _box.write('country_code', 'IR');
    } else {
      await Get.updateLocale(const Locale('en', "US"));
      await _box.write('lang_conde', 'en');
      await _box.write('country_code', 'US');
    }
  }

  static void changeLangByCode(String langCode, String countryCode) async {
    await Get.updateLocale(Locale(langCode, countryCode));
    await _box.write('lang_conde', langCode);
    await _box.write('country_code', countryCode);
  }
}
