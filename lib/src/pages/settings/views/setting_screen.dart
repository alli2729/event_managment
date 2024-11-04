import '../controllers/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingScreen extends GetView<SettingController> {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: Column(
        children: [
          ListTile(
            onTap: controller.onChangeLanguage,
            title: const Text(
              'Change Language to Persian',
              style: TextStyle(fontSize: 18),
            ),
          ),
          ListTile(
            onTap: controller.onLogout,
            title: const Text(
              'Logout',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    ));
  }
}
