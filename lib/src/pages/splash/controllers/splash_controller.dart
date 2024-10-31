import '../../../infrastructure/routes/route_names.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  Future<void> wait() async {
    await Future.delayed(const Duration(seconds: 3));
    Get.offNamed(RouteNames.login);
  }
}
