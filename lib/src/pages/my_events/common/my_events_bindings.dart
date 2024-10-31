import '../controllers/my_events_controller.dart';
import 'package:get/get.dart';

class MyEventsBindings extends Bindings {
  @override
  void dependencies() {
    int? makerId = int.parse(Get.parameters["makerId"] ?? '');
    Get.lazyPut(() => MyEventsController(makerId: makerId));
  }
}
