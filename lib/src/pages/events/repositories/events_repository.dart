import 'dart:convert';
import 'package:either_dart/either.dart';
import 'package:event_managment/generated/locales.g.dart';
import '../models/events_user_dto.dart';
import 'package:http/http.dart' as http;
import '../models/event_model.dart';
import '../models/user_model.dart';
import '../../../infrastructure/common/url_repository.dart';

class EventsRepository {
  Future<Either<String, UserModel>> getUserById({required int id}) async {
    try {
      final url = UrlRepository.userById(id: id);
      final http.Response response = await http.get(url);
      final Map<String, dynamic> result = json.decode(response.body);

      return Right(UserModel.fromJson(result));
    } catch (e) {
      return const Left(
        LocaleKeys.event_managment_app_events_page_somthing_went_wrong,
      );
    }
  }

  Future<Either<String, List<EventModel>>> getAllEvents() async {
    try {
      List<EventModel> events = [];
      final url = UrlRepository.getAllEvents;
      final response = await http.get(url);
      final List<dynamic> result = json.decode(response.body);

      for (Map<String, dynamic> event in result) {
        events.add(EventModel.fromJason(event));
      }

      return Right(events);
    } catch (e) {
      return const Left(
        LocaleKeys.event_managment_app_events_page_somthing_went_wrong,
      );
    }
  }

  Future<Either<String, List<EventModel>>> searchByParameters({
    required String title,
    required String params,
  }) async {
    try {
      List<EventModel> searchedEvents = [];
      final url = UrlRepository.searchEventByParams(
        title: title,
        params: params,
      );
      final response = await http.get(url);
      final List<dynamic> result = json.decode(response.body);
      for (Map<String, dynamic> event in result) {
        searchedEvents.add(EventModel.fromJason(event));
      }
      return Right(searchedEvents);
    } catch (e) {
      return const Left(
        LocaleKeys.event_managment_app_events_page_somthing_went_wrong,
      );
    }
  }

  Future<Either<String, bool>> editBookmarked({
    required EventsUserDto dto,
    required int userId,
  }) async {
    try {
      final url = UrlRepository.userById(id: userId);
      final response = await http.patch(
        url,
        body: json.encode(dto.toJson()),
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode != 200) {
        return const Left(
          LocaleKeys.event_managment_app_events_page_cant_add_bookmark,
        );
      }
      return const Right(true);
    } catch (e) {
      return const Left(
        LocaleKeys.event_managment_app_events_page_somthing_went_wrong,
      );
    }
  }
}
