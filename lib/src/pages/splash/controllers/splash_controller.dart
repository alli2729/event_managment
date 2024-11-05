import '../../../../generated/locales.g.dart';
import '../../../infrastructure/utils/utils.dart';
import '../repositories/splash_repository.dart';
import '../../../infrastructure/routes/route_names.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final _repository = SplashRepository();
  final RxBool isFailed = false.obs;

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

  @override
  void onInit() {
    super.onInit();
    checkServer();
  }
}
