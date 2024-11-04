import 'dart:convert';
import 'package:either_dart/either.dart';
import 'package:http/http.dart' as http;
import '../../../infrastructure/common/url_repository.dart';
import '../models/register_user_dto.dart';

class RegisterRepository {
  Future<Either<int, bool>> registerByDto(
      {required RegisterUserDto dto}) async {
    int? statuscode;
    try {
      final url = UrlRepository.users;
      final http.Response response = await http.post(
        url,
        body: json.encode(dto.toJson()),
        headers: {"Content-Type": "application/json"},
      );
      statuscode = response.statusCode;
      if (statuscode != 201) return const Left(1);

      // final result = json.decode(response.body);
      return const Right(true);
    } catch (e) {
      return const Left(2);
    }
  }

  Future<Either<int, bool>> chekUserExist({required String username}) async {
    // int? statuscode;
    try {
      final url = UrlRepository.userByUsername(username: username);
      final http.Response response = await http.get(url);
      // statuscode = response.statusCode;
      final List<dynamic> result = json.decode(response.body);

      if (result.isNotEmpty) {
        return const Left(3);
      }

      return const Right(true);
    } catch (e) {
      return const Left(2);
    }
  }
}
