import 'dart:convert';
import 'package:either_dart/either.dart';
import '../models/event_model.dart';
import '../models/edit_event_dto.dart';
import '../../../infrastructure/common/url_repository.dart';
import 'package:http/http.dart' as http;

class EditEventRepository {
  Future<Either<String, EventModel>> getEventById({
    required int eventId,
  }) async {
    try {
      final url = UrlRepository.getEventById(eventId: eventId);
      final response = await http.get(url);

      final Map<String, dynamic> event = json.decode(response.body);
      return Right(EventModel.fromJason(event));
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, Map<String, dynamic>>> editEventByDto({
    required EditEventDto dto,
    required int eventId,
  }) async {
    try {
      final url = UrlRepository.getEventById(eventId: eventId);
      final response = await http.patch(
        url,
        body: json.encode(dto.toJason()),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode != 200) {
        return const Left('Cant edit event at this moment');
      }

      final Map<String, dynamic> result = json.decode(response.body);

      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
