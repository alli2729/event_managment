import 'dart:convert';
import 'package:either_dart/either.dart';
import '../../../infrastructure/common/url_repository.dart';
import '../models/add_event_dto.dart';
import 'package:http/http.dart' as http;

class AddEventRepository {
  Future<Either<String, Map<String, dynamic>>> addEventByDto(
      {required AddEventDto dto}) async {
    try {
      final url = UrlRepository.addEvent;
      final response = await http.post(
        url,
        body: json.encode(dto.toJason()),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode != 201) {
        return const Left('cant add event at this time');
      }

      final result = json.decode(response.body);
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
