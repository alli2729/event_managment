import 'dart:convert';
import 'package:either_dart/either.dart';
import '../models/bookmark_user_dto.dart';
import 'package:http/http.dart' as http;
import '../models/event_model.dart';
import '../models/user_model.dart';
import '../../../infrastructure/common/url_repository.dart';

class BookmarkEventRepository {
  Future<Either<String, List<int>>> getUser({required int userId}) async {
    try {
      List<int> bookmarked = [];
      final url = UrlRepository.userById(id: userId);
      final response = await http.get(url);
      final result = json.decode(response.body);
      final user = UserModel.fromJson(result);
      for (var bookmerk in user.bookmarked) {
        bookmarked.add(bookmerk);
      }
      return Right(bookmarked);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<EventModel>>> getBookmarked(
      {required String params}) async {
    try {
      List<EventModel> bookmarkedEvents = [];
      final url = UrlRepository.getEventsByParameters(params: params);
      final response = await http.get(url);
      final List<dynamic> result = json.decode(response.body);

      for (Map<String, dynamic> event in result) {
        bookmarkedEvents.add(EventModel.fromJason(event));
      }
      return Right(bookmarkedEvents);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, bool>> editBookmarks({
    required int userId,
    required BookmarkUserDto dto,
  }) async {
    try {
      final url = UrlRepository.userById(id: userId);
      final response = await http.patch(
        url,
        body: json.encode(dto.toJson()),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode != 200) {
        return const Left('Cant unBook this event');
      }
      return const Right(true);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
