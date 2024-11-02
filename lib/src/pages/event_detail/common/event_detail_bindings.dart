import '../controllers/event_detail_controller.dart';
import 'package:get/get.dart';

class EventDetailBindings extends Bindings {
  @override
  void dependencies() {
    int? eventId = int.parse(Get.parameters["eventId"] ?? '');
    Get.lazyPut(() => EventDetailController(eventId: eventId));
  }
}
