import '../../../infrastructure/common/date_values.dart';
import '../controllers/add_event_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddEventScreen extends GetView<AddEventController> {
  const AddEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Event')),
      body: Form(
        key: controller.addFormKey,
        child: Column(
          children: [
            TextFormField(
              controller: controller.titleController,
            ),
            TextFormField(
              controller: controller.descriptionController,
            ),
            TextFormField(
              controller: controller.priceController,
            ),
            TextFormField(
              controller: controller.capacityController,
            ),
            Obx(
              () => Row(
                children: [
                  DropdownButton<String>(
                    value: controller.day.value,
                    items: DateValues.days,
                    onChanged: controller.selectDay,
                  ),
                  const SizedBox(width: 10),
                  DropdownButton(
                    value: controller.month.value,
                    items: DateValues.months,
                    onChanged: controller.selectMonth,
                  ),
                  const SizedBox(width: 10),
                  DropdownButton(
                    value: controller.year.value,
                    items: DateValues.years,
                    onChanged: controller.selectYear,
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: controller.onAdd,
              child: const Text('Add Event'),
            ),
          ],
        ),
      ),
    );
  }
}
