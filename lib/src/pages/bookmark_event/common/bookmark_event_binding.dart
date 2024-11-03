import '../controllers/bookmark_event_controller.dart';
import 'package:get/get.dart';

class BookmarkEventBinding extends Bindings {
  @override
  void dependencies() {
    int userId = int.parse(Get.parameters["userId"] ?? '');
    Get.lazyPut(() => BookmarkEventController(userId: userId));
  }
}
