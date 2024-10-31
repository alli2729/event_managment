import 'package:get/get.dart';
import '../../../../event_managment.dart';
import '../models/event_model.dart';
import '../../../infrastructure/common/utils.dart';
import '../repositories/events_repository.dart';

class EventsController extends GetxController {
  // Constructor
  final int userId;
  EventsController({required this.userId});

  // Variables
  final _repository = EventsRepository();
  final RxList<EventModel> events = RxList();

  // Functions --------------------------------------------------
  Future<void> getUserById() async {
    final result = await _repository.getUserById(id: userId);
    result.fold(
      (exception) => Utils.showFailSnackBar(message: exception),
      (_) => getAllEvents(),
    );
  }

  Future<void> getAllEvents() async {
    final result = await _repository.getAllEvents();
    result.fold(
      (exception) => Utils.showFailSnackBar(message: exception),
      (eventModels) => events.addAll(eventModels),
    );
  }

  Future<void> onMyEvents() async {
    Get.toNamed(
      RouteNames.myEvents,
      parameters: {"makerId": "$userId"},
    );
  }

  @override
  void onInit() {
    super.onInit();
    getUserById();
  }
}
