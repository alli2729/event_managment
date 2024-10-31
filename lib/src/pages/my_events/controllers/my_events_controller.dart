import '../../../infrastructure/common/utils.dart';
import '../../../infrastructure/routes/route_names.dart';
import '../repositories/my_events_repository.dart';
import 'package:get/get.dart';
import '../models/event_model.dart';

class MyEventsController extends GetxController {
  // constructor
  int makerId;
  MyEventsController({required this.makerId});

  // variables
  final _repository = MyEventsRepository();
  RxList<EventModel> myEvents = RxList();

  // functions
  Future<void> getMyEvents() async {
    final result = await _repository.getEventsByMakerId(makerId: makerId);

    result.fold(
      (exception) => Utils.showFailSnackBar(message: exception),
      (eventModels) => myEvents.addAll(eventModels),
    );
  }

  Future<void> addEvent() async {
    final result = await Get.toNamed(
      RouteNames.addEvent,
      parameters: {"makerId": "$makerId"},
    );
    if (result != null) {
      myEvents.add(EventModel.fromJason(result));
    }
  }

  Future<void> onEdit({required int eventId}) async {
    final result = await Get.toNamed(
      RouteNames.editEvent,
      parameters: {"makerId": "$makerId", "eventId": "$eventId"},
    );

    if (result != null) {
      int index = myEvents.indexWhere((event) => event.id == eventId);
      myEvents[index] = EventModel.fromJason(result);
    }
  }

  Future<void> onRemove({required int id}) async {
    
  }

  @override
  void onInit() {
    super.onInit();
    getMyEvents();
  }
}
