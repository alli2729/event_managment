import 'dart:convert';
import 'package:either_dart/either.dart';
import 'package:http/http.dart' as http;
import '../models/event_model.dart';
import '../../../infrastructure/common/url_repository.dart';

class MyEventsRepository {
  Future<Either<String, List<EventModel>>> getEventsByMakerId(
      {required int makerId}) async {
    try {
      List<EventModel> events = [];
      final url = UrlRepository.getEventsByMakerId(makerId: makerId);
      final http.Response response = await http.get(url);
      final List<dynamic> result = json.decode(response.body);

      for (Map<String, dynamic> event in result) {
        events.add(EventModel.fromJason(event));
      }

      return Right(events);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, bool>> deleteEventById({required int eventId}) async {
    try {
      final url = UrlRepository.deleteEventById(eventId: eventId);
      final http.Response response = await http.delete(url);
      if (response.statusCode != 200) {
        return const Left('cant delete this event at this time');
      }
      return const Right(true);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
