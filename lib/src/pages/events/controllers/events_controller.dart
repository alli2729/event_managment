import 'package:flutter/widgets.dart';
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
  final searchController = TextEditingController();

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
      (eventModels) => events.value = eventModels,
    );
  }

  Future<void> onMyEvents() async {
    final result = await Get.toNamed(
      RouteNames.myEvents,
      parameters: {"makerId": "$userId"},
    );
    if (result == null) {
      getAllEvents();
    }
  }

  void onLogout() {
    Get.offAndToNamed(RouteNames.login);
  }

  Future<void> onViewEvent(int eventId) async {
    await Get.toNamed(
      RouteNames.eventDetail,
      parameters: {"eventId": "$eventId"},
    );

    getAllEvents();
  }

  Future<void> onSearch(String title) async {
    if (title.isEmpty) getAllEvents();

    final result = await _repository.searchByTitle(title: title);
    result.fold(
      (left) {
        Utils.showFailSnackBar(message: 'Cant search right now');
      },
      (searchedEvents) {
        events.value = searchedEvents;
      },
    );
  }

  @override
  void onInit() {
    super.onInit();
    getUserById();
  }
}
