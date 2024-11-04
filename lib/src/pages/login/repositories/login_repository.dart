import 'dart:convert';
import 'package:either_dart/either.dart';
import 'package:http/http.dart' as http;
import '../../../infrastructure/common/url_repository.dart';

class LoginRepository {
  Future<Either<String, Map<String, dynamic>>> login({
    required String username,
    required String password,
  }) async {
    int? statuscode;
    try {
      final url = UrlRepository.loginByUsername(username: username);

      final http.Response response = await http.get(url);
      statuscode = response.statusCode;
      final List<dynamic> result = json.decode(response.body);

      if (result.isEmpty) return const Left('User Not Found');

      if (result.first["password"] != password) {
        return const Left("Password incorrect");
      }

      return Right(result.first);
    } catch (e) {
      return Left('somthing went wrong : $statuscode');
    }
  }
}
