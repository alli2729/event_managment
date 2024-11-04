import '../controllers/setting_controller.dart';
import 'package:get/get.dart';

class SettingBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettingController());
  }
}
