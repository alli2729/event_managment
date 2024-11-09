import '../../../../generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../infrastructure/routes/route_names.dart';
import '../models/events_user_dto.dart';
import '../models/event_model.dart';
import '../../../infrastructure/utils/utils.dart';
import '../repositories/events_repository.dart';

class EventsController extends GetxController {
  // Constructor
  final int userId;
  EventsController({required this.userId});

  // Variables
  final _repository = EventsRepository();
  final RxList<EventModel> events = RxList();
  final RxList bookmarkedEvents = RxList();
  final searchController = TextEditingController();
  RxBool isFilled = false.obs;
  RxBool isExpired = false.obs;
  RxBool isSort = false.obs;
  RxBool isLimited = false.obs;
  RxBool isLoading = false.obs;
  RxBool isRetry = false.obs;
  RxBool isSearch = false.obs;

  Rx<RangeValues> priceLimits = Rx(const RangeValues(0, 1));
  double max = 1;
  double min = 0;

  // Functions --------------------------------------------------
  Future<void> getUserById() async {
    isLoading.value = true;
    isRetry.value = false;
    final result = await _repository.getUserById(id: userId);
    result.fold(
      (exception) {
        isLoading.value = false;
        isRetry.value = true;
        Utils.showFailSnackBar(message: exception.tr);
      },
      (user) {
        bookmarkedEvents.value = user.bookmarked;
        getAllEvents();
      },
    );
  }

  Future<void> getAllEvents() async {
    isSearch.value = true;
    final result = await _repository.getAllEvents();
    result.fold(
      (exception) {
        isLoading.value = false;
        isRetry.value = true;
        isSearch.value = false;
        Utils.showFailSnackBar(message: exception.tr);
      },
      (eventModels) {
        events.value = eventModels;
        calculateMinMax();
      },
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

  Future<void> onSetting() async {
    await Get.toNamed(RouteNames.settings);
  }

  Future<void> onViewEvent(int eventId) async {
    await Get.toNamed(
      RouteNames.eventDetail,
      parameters: {"eventId": "$eventId"},
    );

    getAllEvents();
  }

  Future<void> onBookmarks() async {
    await Get.toNamed(
      RouteNames.bookmark,
      parameters: {"userId": "$userId"},
    );
    getUserById();
  }

  Future<void> onSearch(String title) async {
    isSearch.value = true;
    if (title.isEmpty && parameters.isEmpty) getAllEvents();

    final result = await _repository.searchByParameters(
      title: title,
      params: parameters,
    );

    result.fold(
      (_) {
        isSearch.value = false;
        Utils.showFailSnackBar(
          message: LocaleKeys.event_managment_app_events_page_cant_search.tr,
        );
      },
      (searchedEvents) {
        isSearch.value = false;
        return events.value = searchedEvents;
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

    if (isSort.value) parm = '$parm&_sort=dateTime&_order=desc';

    if (isLimited.value) {
      parm = '$parm&price_gte=$minPrice&price_lte=$maxPrice';
    }

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
    if (events.isEmpty) {
      isLoading.value = false;
      isRetry.value = false;
      isSearch.value = false;
      return;
    }

    double max = 0;
    double min = double.infinity;
    for (var event in events) {
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

  Future<void> onBookmark(int eventId) async {
    (bookmarkedEvents.contains(eventId))
        ? bookmarkedEvents.remove(eventId)
        : bookmarkedEvents.add(eventId);

    final EventsUserDto dto = EventsUserDto(bookmarked: bookmarkedEvents);
    final result = await _repository.editBookmarked(dto: dto, userId: userId);
    result.fold(
      (exception) {
        Utils.showFailSnackBar(message: exception.tr);
      },
      (_) {
        Utils.showSuccessSnackBar(
          message: LocaleKeys.event_managment_app_events_page_done.tr,
        );
      },
    );
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
    getUserById();
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }
}
