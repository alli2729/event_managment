import 'dart:convert';
import 'dart:typed_data';
import '../../../infrastructure/common/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/add_event_dto.dart';
import '../repositories/add_event_repository.dart';

class AddEventController extends GetxController {
  // constructor
  int makerId;
  AddEventController({required this.makerId});

  // variables
  final _repository = AddEventRepository();
  final addFormKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final capacityController = TextEditingController();

  RxString day = '01'.obs;
  RxString month = '01'.obs;
  RxString year = '2022'.obs;

  Rxn<Uint8List> image = Rxn();
  String imageBase64 = '';

  RxBool isLoading = false.obs;

  // functions
  void selectDay(String? selectedDay) => day.value = selectedDay!;
  void selectMonth(String? selectedMonth) => month.value = selectedMonth!;
  void selectYear(String? selectedYear) => year.value = selectedYear!;

  Future<void> onAddEvent() async {
    if (!(addFormKey.currentState?.validate() ?? false)) return;

    final String dateTime = "$year-$month-$day";

    if (!validDate(dateTime)) {
      Utils.showFailSnackBar(message: 'date must be after today');
      return;
    }

    isLoading.value = true;

    final AddEventDto dto = AddEventDto(
      makerId: makerId,
      title: titleController.text,
      description: descriptionController.text,
      dateTime: dateTime,
      capacity: int.parse(capacityController.text),
      price: double.parse(priceController.text),
      attendees: 0,
      imageBase64: imageBase64,
    );

    final result = await _repository.addEventByDto(dto: dto);
    result.fold(
      (exception) {
        isLoading.value = false;
        Utils.showFailSnackBar(message: exception);
      },
      (eventJson) {
        isLoading.value = false;
        Get.back(result: eventJson);
      },
    );
  }

  Future<void> onPicture() async {
    final result = await _repository.pickImage();
    result.fold(
      (left) {
        if (left) Utils.showFailSnackBar(message: 'Faild');
      },
      (imageBase64) {
        image.value = base64Decode(imageBase64);
        this.imageBase64 = imageBase64;
      },
    );
  }

  void onClear() {
    image.value = null;
    imageBase64 = '';
  }

  //validation
  String? validate(String? value) {
    if (value == null || value.isEmpty) return 'required';
    return null;
  }

  bool validDate(String dateTime) {
    final now = DateTime.now();
    final input = DateTime.parse(dateTime);

    return (input.isBefore(now)) ? false : true;
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    capacityController.dispose();
  }
}
