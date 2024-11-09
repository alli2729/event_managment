import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../localization_service.dart';
import '../../../infrastructure/routes/route_names.dart';

class SettingController extends GetxController {
  final _box = GetStorage();

  Future<void> onLogout() async {
    await _box.remove('credential');
    await Get.offAllNamed(RouteNames.login);
  }

  void onChangeLanguage() => LocalizationService.changeLang();
}
