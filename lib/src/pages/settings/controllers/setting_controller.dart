import '../../../infrastructure/routes/route_names.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  Future<void> onLogout() async {
    await Get.offAllNamed(RouteNames.login);
  }

  void onChangeLanguage() {}
}
