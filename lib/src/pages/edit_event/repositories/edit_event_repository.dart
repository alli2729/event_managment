import 'dart:convert';
import 'dart:typed_data';
import 'package:either_dart/either.dart';
import 'package:file_picker/file_picker.dart';
import '../../../../generated/locales.g.dart';
import '../models/event_model.dart';
import '../models/edit_event_dto.dart';
import '../../../infrastructure/common/url_repository.dart';
import 'package:http/http.dart' as http;

class EditEventRepository {
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
        LocaleKeys.event_managment_app_edit_event_page_somthing_went_wrong,
      );
    }
  }

  Future<Either<String, Map<String, dynamic>>> editEventByDto({
    required EditEventDto dto,
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
          LocaleKeys.event_managment_app_edit_event_page_cant_edit,
        );
      }

      final Map<String, dynamic> result = json.decode(response.body);

      return Right(result);
    } catch (e) {
      return const Left(
        LocaleKeys.event_managment_app_edit_event_page_somthing_went_wrong,
      );
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
