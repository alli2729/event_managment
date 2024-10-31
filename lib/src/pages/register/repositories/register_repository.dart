import 'dart:convert';
import 'package:either_dart/either.dart';
import 'package:http/http.dart' as http;
import '../../../infrastructure/common/url_repository.dart';
import '../models/register_user_dto.dart';

class RegisterRepository {
  Future<Either<String, bool>> registerByDto(
      {required RegisterUserDto dto}) async {
    try {
      final url = UrlRepository.users;
      final http.Response response = await http.post(
        url,
        body: json.encode(dto.toJson()),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode != 201) return const Left('Error');

      // final result = json.decode(response.body);
      return const Right(true);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, bool>> chekUserExist({required String username}) async {
    try {
      final url = UrlRepository.userByUsername(username: username);
      final http.Response response = await http.get(url);
      final List<dynamic> result = json.decode(response.body);

      if (result.isNotEmpty) {
        return Left('username: "$username" is already taken');
      }

      return const Right(true);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
