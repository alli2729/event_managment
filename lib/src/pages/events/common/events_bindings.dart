import '../controllers/events_controller.dart';
import 'package:get/get.dart';

class EventsBindings extends Bindings {
  @override
  void dependencies() {
    int? userId = int.parse(Get.parameters["userId"] ?? "");
    Get.lazyPut(() => EventsController(userId: userId));
  }
}
