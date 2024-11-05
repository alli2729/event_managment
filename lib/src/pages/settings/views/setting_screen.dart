import '../../../../generated/locales.g.dart';
import '../controllers/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingScreen extends GetView<SettingController> {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
          title: Text(
        LocaleKeys.event_managment_app_settings_page_settings.tr,
      )),
      body: Column(
        children: [
          ListTile(
            onTap: controller.onChangeLanguage,
            title: Text(
              LocaleKeys.event_managment_app_settings_page_change_lang.tr,
              style: const TextStyle(fontSize: 18),
            ),
          ),
          ListTile(
            onTap: controller.onLogout,
            title: Text(
              LocaleKeys.event_managment_app_settings_page_logout.tr,
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    ));
  }
}
