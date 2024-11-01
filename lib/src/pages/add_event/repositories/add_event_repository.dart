import 'dart:convert';
import 'dart:typed_data';
import 'package:either_dart/either.dart';
import 'package:file_picker/file_picker.dart';
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

  Future<Either<bool, String>> pickImage() async {
    Uint8List? imageData;
    // Using FilePicker for web-compatible file selection
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null && result.files.single.bytes != null) {
      imageData = result.files.single.bytes;
      // Convert image to base64
      return Right(base64Encode(imageData!));
    }
    return const Left(false);
  }
}
