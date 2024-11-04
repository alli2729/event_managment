import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../infrastructure/routes/route_names.dart';

class SettingController extends GetxController {
  Future<void> onLogout() async {
    await Get.offAllNamed(RouteNames.login);
  }

  void onChangeLanguage() {
    (Get.locale == const Locale('en', 'US'))
        ? Get.updateLocale(const Locale('fa', 'IR'))
        : Get.updateLocale(const Locale('en', "US"));
  }
}
