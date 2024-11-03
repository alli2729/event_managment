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

  @override
  void onInit() {
    super.onInit();
    getUser();
  }
}
