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

  // functions

  void selectDay(String? selectedDay) => day.value = selectedDay!;
  void selectMonth(String? selectedMonth) => month.value = selectedMonth!;
  void selectYear(String? selectedYear) => year.value = selectedYear!;

  Future<void> onAdd() async {
    final String dateTime = "$year-$month-$day";
    final AddEventDto dto = AddEventDto(
      makerId: makerId,
      title: titleController.text,
      description: descriptionController.text,
      dateTime: dateTime,
      capacity: int.parse(capacityController.text),
      price: double.parse(priceController.text),
    );

    final result = await _repository.addEventByDto(dto: dto);
    result.fold(
      (exception) {
        Utils.showFailSnackBar(message: exception);
      },
      (eventJson) {
        Get.back(result: eventJson);
      },
    );
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
