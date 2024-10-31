import '../controllers/add_event_controller.dart';
import 'package:get/get.dart';

class AddEventBindings extends Bindings {
  @override
  void dependencies() {
    int? makerId = int.parse(Get.parameters["makerId"] ?? '');
    Get.lazyPut(() => AddEventController(makerId: makerId));
  }
}
