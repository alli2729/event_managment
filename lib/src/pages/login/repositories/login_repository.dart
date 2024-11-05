import 'dart:convert';
import 'package:either_dart/either.dart';
import 'package:http/http.dart' as http;
import '../../../../generated/locales.g.dart';
import '../../../infrastructure/common/url_repository.dart';

class LoginRepository {
  Future<Either<String, Map<String, dynamic>>> login({
    required String username,
    required String password,
  }) async {
    try {
      final url = UrlRepository.loginByUsername(username: username);

      final http.Response response = await http.get(url);
      final List<dynamic> result = json.decode(response.body);

      if (result.isEmpty) {
        return const Left(
            LocaleKeys.event_managment_app_login_page_user_not_found);
      }

      if (result.first["password"] != password) {
        return const Left(
            LocaleKeys.event_managment_app_login_page_password_incorrect);
      }

      return Right(result.first);
    } catch (e) {
      return const Left(
          LocaleKeys.event_managment_app_login_page_somthing_went_wrong);
    }
  }
}
