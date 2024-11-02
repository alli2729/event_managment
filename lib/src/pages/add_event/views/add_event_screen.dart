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
              validator: controller.validate,
            ),
            TextFormField(
              controller: controller.descriptionController,
              validator: controller.validate,
            ),
            TextFormField(
              controller: controller.priceController,
              validator: controller.validate,
            ),
            TextFormField(
              controller: controller.capacityController,
              validator: controller.validate,
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
            IconButton(
              onPressed: controller.onPicture,
              icon: const Icon(Icons.photo),
            ),
            const SizedBox(height: 24),
            IconButton(
              onPressed: controller.onClear,
              icon: const Icon(Icons.clear),
            ),
            const SizedBox(height: 24),
            Obx(
              () => (controller.image.value == null)
                  ? const Text('no image')
                  : Image.memory(controller.image.value!),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: controller.onAddEvent,
              child: const Text('Add Event'),
            ),
          ],
        ),
      ),
    );
  }
}
