import 'dart:convert';
import 'package:either_dart/either.dart';
import 'package:http/http.dart' as http;
import '../../../../generated/locales.g.dart';
import '../../../infrastructure/common/url_repository.dart';
import '../models/register_user_dto.dart';

class RegisterRepository {
  Future<Either<String, bool>> registerByDto(
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
      if (statuscode != 201) {
        return const Left(LocaleKeys.event_managment_app_register_page_error);
      }

      // final result = json.decode(response.body);
      return const Right(true);
    } catch (e) {
      return const Left(
          LocaleKeys.event_managment_app_register_page_somthing_went_wrong);
    }
  }

  Future<Either<String, bool>> chekUserExist({required String username}) async {
    // int? statuscode;
    try {
      final url = UrlRepository.userByUsername(username: username);
      final http.Response response = await http.get(url);
      // statuscode = response.statusCode;
      final List<dynamic> result = json.decode(response.body);

      if (result.isNotEmpty) {
        return const Left(LocaleKeys
            .event_managment_app_register_page_username_already_taken);
      }

      return const Right(true);
    } catch (e) {
      return const Left(
          LocaleKeys.event_managment_app_register_page_somthing_went_wrong);
    }
  }
}
