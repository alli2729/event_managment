import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import '../../../../generated/locales.g.dart';
import '../../../../localization_service.dart';
import '../../../infrastructure/utils/utils.dart';
import '../repositories/splash_repository.dart';
import '../../../infrastructure/routes/route_names.dart';

class SplashController extends GetxController {
  final _repository = SplashRepository();
  final RxBool isFailed = false.obs;
  final _box = GetStorage();

  Future<void> checkServer() async {
    isFailed.value = false;

    final isConnected = await _repository.checkServer();

    if (isConnected) {
      isFailed.value = false;
      Get.offNamed(RouteNames.login);
    } else {
      Utils.showFailSnackBar(
        duration: 10,
        message: LocaleKeys.event_managment_app_splash_screen_try_again.tr,
      );
      isFailed.value = true;
    }
  }

  Future<void> reciveData() async {
    final String? lang = _box.read('lang_conde');
    final String? country = _box.read('country_code');
    if (lang != null && country != null) {
      LocalizationService.changeLangByCode(lang, country);
    } else {
      LocalizationService.changeLangByCode('en', 'US');
    }
  }

  @override
  void onInit() {
    super.onInit();
    reciveData();
    checkServer();
  }
}
