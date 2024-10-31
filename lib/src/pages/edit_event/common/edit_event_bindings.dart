import '../controllers/edit_event_controller.dart';
import 'package:get/get.dart';

class EditEventBindings extends Bindings {
  @override
  void dependencies() {
    int? makerId = int.parse(Get.parameters["makerId"] ?? '');
    int? eventId = int.parse(Get.parameters["eventId"] ?? '');
    Get.lazyPut(() => EditEventController(makerId: makerId, eventId: eventId));
  }
}
