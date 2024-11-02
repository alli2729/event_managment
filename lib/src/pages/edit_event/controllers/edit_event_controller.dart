import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../infrastructure/common/utils.dart';
import '../models/edit_event_dto.dart';
import '../models/event_model.dart';
import '../repositories/edit_event_repository.dart';

class EditEventController extends GetxController {
  // constructor
  int makerId;
  int eventId;
  EditEventController({required this.makerId, required this.eventId});

  // variables
  final _repository = EditEventRepository();
  final addFormKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final capacityController = TextEditingController();

  RxString day = '01'.obs;
  RxString month = '01'.obs;
  RxString year = '2024'.obs;

  Rxn<Uint8List> image = Rxn();
  String? imageBase64 = '';

  EventModel event = EventModel(
    id: 0,
    makerId: 0,
    title: 'title',
    description: 'description',
    dateTime: DateTime.parse('2022-01-01'),
    capacity: 0,
    price: 0,
    imageBase64: '',
  );

  // functions
  void selectDay(String? selectedDay) => day.value = selectedDay!;
  void selectMonth(String? selectedMonth) => month.value = selectedMonth!;
  void selectYear(String? selectedYear) => year.value = selectedYear!;

  Future<void> getEvent() async {
    final result = await _repository.getEventById(eventId: eventId);
    result.fold(
      (exception) {
        Utils.showFailSnackBar(message: exception);
      },
      (eventJson) {
        event = eventJson;
        imageBase64 = event.imageBase64;
        if (event.imageBase64!.isNotEmpty) {
          image.value = base64Decode(event.imageBase64!);
        }
        fillControllers();
      },
    );
  }

  void fillControllers() {
    titleController.text = event.title;
    descriptionController.text = event.description;
    priceController.text = event.price.toString();
    capacityController.text = event.capacity.toString();
    day.value = twoDigit(event.dateTime.day.toString());
    month.value = twoDigit(event.dateTime.month.toString());
    year.value = event.dateTime.year.toString();
  }

  Future<void> onEdit() async {
    if (!(addFormKey.currentState?.validate() ?? false)) return;

    final String dateTime = "$year-$month-$day";

    if (!validDate(dateTime)) {
      Utils.showFailSnackBar(message: 'date must be after today');
      return;
    }

    final EditEventDto dto = EditEventDto(
      makerId: makerId,
      title: titleController.text,
      description: descriptionController.text,
      dateTime: dateTime,
      capacity: int.parse(capacityController.text),
      price: double.parse(priceController.text),
      attendent: 0,
      imageBase64: imageBase64,
    );

    final result = await _repository.editEventByDto(dto: dto, eventId: eventId);
    result.fold(
      (exception) {
        Utils.showFailSnackBar(message: exception);
      },
      (eventJson) {
        Get.back(result: eventJson);
      },
    );
  }

  Future<void> onPicture() async {
    final result = await _repository.pickImage();
    result.fold(
      (exception) {
        if (exception) Utils.showFailSnackBar(message: 'Faild');
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

  String twoDigit(String value) => (value.length == 1) ? '0$value' : value;

  @override
  void onInit() {
    super.onInit();
    getEvent();
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
