import 'dart:convert';
import '../../../../generated/locales.g.dart';
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
      return const Left(
        LocaleKeys.event_managment_app_detail_page_somthing_went_wrong,
      );
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

      if (response.statusCode != 200) {
        return const Left(
          LocaleKeys.event_managment_app_detail_page_cant_buy,
        );
      }
      return const Right(true);
    } catch (e) {
      return const Left(
        LocaleKeys.event_managment_app_detail_page_somthing_went_wrong,
      );
    }
  }
}
