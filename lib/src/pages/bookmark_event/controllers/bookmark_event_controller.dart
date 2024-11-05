import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../generated/locales.g.dart';
import '../models/bookmark_user_dto.dart';
import '../models/event_model.dart';
import '../../../infrastructure/utils/utils.dart';
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
  RxBool isLoading = false.obs;
  RxBool isSearch = false.obs;
  RxBool isRetry = false.obs;

  Rx<RangeValues> priceLimits = Rx(const RangeValues(0, 1));
  double max = 1;
  double min = 0;

  // functions
  Future<void> getUser() async {
    isRetry.value = false;
    isSearch.value = true;
    final result = await _repository.getUser(userId: userId);
    result.fold(
      (exception) {
        isLoading.value = false;
        isSearch.value = false;
        isRetry.value = true;
        Utils.showFailSnackBar(message: exception.tr);
      },
      (bookmarkedList) {
        if (bookmarkedList.isEmpty) {
          isRetry.value = false;
          isLoading.value = false;
          isSearch.value = false;
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
      (exception) {
        isLoading.value = false;
        isSearch.value = false;
        isRetry.value = true;
        Utils.showFailSnackBar(message: exception.tr);
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
        Utils.showFailSnackBar(message: exception.tr);
      },
      (_) {
        Utils.showSuccessSnackBar(
          message: LocaleKeys.event_managment_app_bookmark_page_done.tr,
        );
        bookmarkedEvents.removeWhere((element) => element.id == eventId);
      },
    );
  }

  Future<void> onSearch(String title) async {
    isSearch.value = true;
    if (title.isEmpty) getBookmarked();

    String search = '$params$parameters';

    final result = await _repository.searchByParameters(
      title: title,
      params: search,
    );

    result.fold(
      (left) {
        isSearch.value = false;
        Utils.showFailSnackBar(
          message: LocaleKeys.event_managment_app_bookmark_page_cant_search.tr,
        );
      },
      (searchedEvents) {
        isSearch.value = false;
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
    if (bookmarkedEvents.isEmpty) {
      isLoading.value = false;
      isRetry.value = false;
      isSearch.value = false;
      return;
    }

    double max = 0;
    double min = double.infinity;
    for (var event in bookmarkedEvents) {
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
    getUser();
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }
}
