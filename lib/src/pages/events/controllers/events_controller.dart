import 'package:flutter/material.dart';
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
  RxBool isFilled = false.obs;
  RxBool isExpired = false.obs;
  RxBool isSort = false.obs;

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
    if (title.isEmpty && parameters.isEmpty) getAllEvents();

    final result = await _repository.searchByParameters(
      title: title,
      params: parameters,
    );

    result.fold(
      (_) => Utils.showFailSnackBar(message: 'Cant search right now'),
      (searchedEvents) => events.value = searchedEvents,
    );
  }

  void showDialog(Widget dialog) async {
    final result = await Get.dialog(dialog);
    if (result != null) {
      onSearch(searchController.text);
    }
  }

  String get parameters {
    String parm = '';
    if (isFilled.value) parm = '$parm&filled_ne=true';

    if (isExpired.value) {
      final time = DateTime.now();
      parm = '$parm&dateTime_gte=${time.year}-${time.month}-${time.day}';
    }

    if (isSort.value) parm = '$parm&_sort=dateTime&_order=desc';

    return parm;
  }

  void onResetFilters() {
    isFilled.value = false;
    isExpired.value = false;
    isSort.value = false;
    Get.back(result: true);
  }

  @override
  void onInit() {
    super.onInit();
    getUserById();
  }
}
