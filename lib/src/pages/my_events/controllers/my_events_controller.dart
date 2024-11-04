import 'package:flutter/material.dart';
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
  final searchController = TextEditingController();
  RxBool isFilled = false.obs;
  RxBool isExpired = false.obs;
  RxBool isSort = false.obs;
  RxBool isLimited = false.obs;
  RxBool isLoading = false.obs;
  RxBool isSearch = false.obs;
  RxBool isRetry = false.obs;

  Rx<RangeValues> priceLimits = Rx(const RangeValues(0, 1));
  double max = 1;
  double min = 0;

  // functions
  Future<void> getMyEvents() async {
    // isLoading.value = true;
    isRetry.value = false;
    isSearch.value = true;
    final result = await _repository.getEventsByMakerId(makerId: makerId);

    result.fold(
      (exception) {
        isLoading.value = false;
        isSearch.value = false;
        isRetry.value = true;
        Utils.showFailSnackBar(message: exception);
      },
      (eventModels) {
        myEvents.value = eventModels;
        calculateMinMax();
      },
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

  Future<void> onRemove({required int eventId}) async {
    int index = myEvents.indexWhere((event) => event.id == eventId);
    if (myEvents[index].attendees != 0) {
      Utils.showFailSnackBar(message: 'cant delete non empty events !');
      return;
    }
    final result = await _repository.deleteEventById(eventId: eventId);
    result.fold(
      (exception) {
        Utils.showFailSnackBar(message: exception);
      },
      (_) {
        myEvents.removeAt(index);
        Utils.showSuccessSnackBar(message: 'Successfully deleted');
      },
    );
  }

  Future<void> onSearch(String title) async {
    isSearch.value = true;
    if (title.isEmpty) getMyEvents();

    final result = await _repository.searchByParameters(
      title: title,
      makerId: makerId,
      params: parameters,
    );

    result.fold(
      (left) {
        isSearch.value = false;
        Utils.showFailSnackBar(message: 'Cant search right now');
      },
      (searchedEvents) {
        isSearch.value = false;
        myEvents.value = searchedEvents;
      },
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

    if (isLimited.value) {
      parm = '$parm&price_gte=$minPrice&price_lte=$maxPrice';
    }

    if (isSort.value) parm = '$parm&_sort=dateTime&_order=desc';
    return parm;
  }

  void onResetFilters() {
    isFilled.value = false;
    isExpired.value = false;
    isSort.value = false;
    isLimited.value = false;
    Get.back(result: true);
  }

  void onPriceChanged(v) => priceLimits.value = v;

  void calculateMinMax() {
    if (myEvents.isEmpty) {
      isLoading.value = false;
      isRetry.value = false;
      isSearch.value = false;
      return;
    }

    double max = 0;
    double min = double.infinity;
    for (var event in myEvents) {
      if (event.price > max) max = event.price;
      if (event.price < min) min = event.price;
    }
    this.max = max;
    this.min = min;
    priceLimits = Rx(RangeValues(min, max));
    isLoading.value = false;
    isRetry.value = false;
    isSearch.value = false;
  }

  // getters
  RxBool get filtered =>
      (isLimited.value || isExpired.value || isFilled.value || isSort.value)
          ? true.obs
          : false.obs;

  double get minPrice => priceLimits.value.start.floorToDouble();
  double get maxPrice => priceLimits.value.end.floorToDouble();

  @override
  void onInit() {
    super.onInit();
    isLoading.value = true;
    getMyEvents();
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }
}
