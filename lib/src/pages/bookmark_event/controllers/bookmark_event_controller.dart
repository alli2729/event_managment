import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/bookmark_user_dto.dart';
import '../models/event_model.dart';
import '../../../infrastructure/common/utils.dart';
import '../repositories/bookmark_event_repository.dart';

class BookmarkEventController extends GetxController {
  // constructor
  int userId;
  BookmarkEventController({required this.userId});

  // variables
  final _repository = BookmarkEventRepository();
  RxList<EventModel> bookmarkedEvents = RxList();
  List bookmarkedIds = [];
  String params = '';

  final searchController = TextEditingController();
  RxBool isFilled = false.obs;
  RxBool isExpired = false.obs;
  RxBool isSort = false.obs;
  RxBool isLimited = false.obs;
  Rx<RangeValues> priceLimits = Rx(const RangeValues(0, 1));
  double max = 1;
  double min = 0;

  // functions
  Future<void> getUser() async {
    final result = await _repository.getUser(userId: userId);
    result.fold(
      (left) {
        Utils.showFailSnackBar(message: left);
      },
      (bookmarkedList) {
        if (bookmarkedList.isEmpty) {
          return;
        }
        bookmarkedIds = bookmarkedList;
        listToParameters(bookmarkedList);
      },
    );
  }

  void listToParameters(List bookmarks) {
    for (int bookmark in bookmarks) {
      params = '$params&id=$bookmark';
    }
    getBookmarked();
  }

  Future<void> getBookmarked() async {
    final result = await _repository.getBookmarked(params: params);
    result.fold(
      (left) {
        Utils.showFailSnackBar(message: left);
      },
      (eventsList) {
        bookmarkedEvents.value = eventsList;
        calculateMinMax();
      },
    );
  }

  Future<void> onBookmark({required int eventId}) async {
    bookmarkedIds.remove(eventId);
    final BookmarkUserDto dto = BookmarkUserDto(bookmarked: bookmarkedIds);
    final result = await _repository.editBookmarks(userId: userId, dto: dto);
    result.fold(
      (exception) {
        Utils.showFailSnackBar(message: exception);
      },
      (_) {
        Utils.showSuccessSnackBar(message: 'Done !');
        bookmarkedEvents.removeWhere((element) => element.id == eventId);
      },
    );
  }

  Future<void> onSearch(String title) async {
    if (title.isEmpty) getBookmarked();

    String search = '$params$parameters';

    final result = await _repository.searchByParameters(
      title: title,
      params: search,
    );

    result.fold(
      (left) {
        Utils.showFailSnackBar(message: 'Cant search right now');
      },
      (searchedEvents) {
        bookmarkedEvents.value = searchedEvents;
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
    if (bookmarkedEvents.isEmpty) return;

    double max = 0;
    double min = double.infinity;
    for (var event in bookmarkedEvents) {
      if (event.price > max) max = event.price;
      if (event.price < min) min = event.price;
    }
    this.max = max;
    this.min = min;
    priceLimits = Rx(RangeValues(min, max));
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
    getUser();
  }
}
