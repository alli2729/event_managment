import 'dart:convert';
import 'package:either_dart/either.dart';
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
      return Left(e.toString());
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
      return Left(e.toString());
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
      return Left(e.toString());
    }
  }
}
