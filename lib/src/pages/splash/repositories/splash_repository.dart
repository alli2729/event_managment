import '../../../infrastructure/common/url_repository.dart';
import 'package:http/http.dart' as http;

class SplashRepository {
  Future<bool> checkServer() async {
    try {
      final url = UrlRepository.base;
      final response = await http.head(url);

      return (response.statusCode != 200) ? false : true;
    } catch (e) {
      return false;
    }
  }
}
