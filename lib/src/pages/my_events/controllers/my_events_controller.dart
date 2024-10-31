import '../../../infrastructure/common/utils.dart';
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

  @override
  void onInit() {
    super.onInit();
    getMyEvents();
  }
}
