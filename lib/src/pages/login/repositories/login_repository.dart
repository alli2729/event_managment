import 'dart:convert';
import 'package:either_dart/either.dart';
import 'package:http/http.dart' as http;
import '../../../infrastructure/common/url_repository.dart';

class LoginRepository {
  Future<Either<int, Map<String, dynamic>>> login({
    required String username,
    required String password,
  }) async {
    try {
      final url = UrlRepository.loginByUsername(username: username);

      final http.Response response = await http.get(url);
      final List<dynamic> result = json.decode(response.body);

      if (result.isEmpty) return const Left(1);

      if (result.first["password"] != password) {
        return const Left(2);
      }

      return Right(result.first);
    } catch (e) {
      return const Left(3);
    }
  }
}
