import 'dart:convert';
import 'dart:typed_data';
import 'package:event_managment/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../infrastructure/utils/utils.dart';
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

  RxString minute = '00'.obs;
  RxString hour = '00'.obs;
  RxString day = '01'.obs;
  RxString month = '01'.obs;
  RxString year = '2024'.obs;

  Rxn<Uint8List> image = Rxn();
  String? imageBase64 = '';

  RxBool isLoading = false.obs;
  RxBool isFetching = false.obs;

  EventModel event = EventModel(
    id: 0,
    makerId: 0,
    title: 'title',
    description: 'description',
    dateTime: DateTime.parse('2022-01-01'),
    capacity: 0,
    price: 0,
    imageBase64: '',
    filled: false,
  );

  // functions
  void selectMinute(String? selectedMinute) => minute.value = selectedMinute!;
  void selectHour(String? selectedHour) => hour.value = selectedHour!;
  void selectDay(String? selectedDay) => day.value = selectedDay!;
  void selectMonth(String? selectedMonth) => month.value = selectedMonth!;
  void selectYear(String? selectedYear) => year.value = selectedYear!;

  Future<void> getEvent() async {
    isFetching.value = true;
    final result = await _repository.getEventById(eventId: eventId);
    result.fold(
      (exception) {
        isFetching.value = false;
        Utils.showFailSnackBar(message: exception.tr);
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
    hour.value = twoDigit(event.dateTime.hour.toString());
    minute.value = twoDigit(event.dateTime.minute.toString());
    day.value = twoDigit(event.dateTime.day.toString());
    month.value = twoDigit(event.dateTime.month.toString());
    year.value = event.dateTime.year.toString();
    isFetching.value = false;
  }

  Future<void> onEdit() async {
    if (!(addFormKey.currentState?.validate() ?? false)) return;

    final String dateTime = "$year-$month-$day $hour:$minute:00";

    if (!validDate(dateTime)) {
      Utils.showFailSnackBar(
        message: LocaleKeys.event_managment_app_edit_event_page_date_error.tr,
      );
      return;
    }

    isLoading.value = true;

    final EditEventDto dto = EditEventDto(
      makerId: makerId,
      title: titleController.text,
      description: descriptionController.text,
      dateTime: dateTime,
      capacity: int.parse(capacityController.text),
      price: double.parse(priceController.text),
      attendees: event.attendees!,
      imageBase64: imageBase64,
      filled: event.filled,
    );

    final result = await _repository.editEventByDto(dto: dto, eventId: eventId);
    result.fold(
      (exception) {
        isLoading.value = false;
        Utils.showFailSnackBar(message: exception.tr);
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
      (exception) {
        if (exception) {
          Utils.showFailSnackBar(
            message: LocaleKeys.event_managment_app_edit_event_page_failed.tr,
          );
        }
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
    if (value == null || value.isEmpty) {
      return LocaleKeys.event_managment_app_edit_event_page_required.tr;
    }
    if (value[0] == '') {
      return 'cant start with space';
    }

    return null;
  }

  String? priceValidate(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.event_managment_app_add_event_page_required.tr;
    }
    if (value[0] == '') {
      return 'cant start with space';
    }
    if (value[0] == '0') {
      return 'cant start with 0';
    }
    if (!int.parse(value).isGreaterThan(0)) {
      return 'cant be empty';
    }

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
