import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:event_managment/event_managment.dart' as package;

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: package.LocalizationService.defaultLocale,
      translationsKeys: package.LocalizationService.keys,
      theme: package.AppTheme.theme,
      debugShowCheckedModeBanner: false,
      initialRoute: package.RouteNames.splash,
      getPages: package.RoutePages.pages,
    );
  }
}
