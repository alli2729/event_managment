import 'dart:convert';
import '../models/buy_event_dto.dart';
import 'package:http/http.dart' as http;
import 'package:either_dart/either.dart';
import '../../../infrastructure/common/url_repository.dart';
import '../models/event_model.dart';

class EventDetailRepository {
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

  Future<Either<String, bool>> buyEvent({
    required BuyEventDto dto,
    required int eventId,
  }) async {
    try {
      final url = UrlRepository.getEventById(eventId: eventId);
      final response = await http.patch(
        url,
        body: json.encode(dto.toJason()),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode != 200) return const Left('Cant Buy Event');
      return const Right(true);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
