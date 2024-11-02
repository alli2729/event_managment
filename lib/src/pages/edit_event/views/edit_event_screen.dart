import '../../../infrastructure/common/date_values.dart';
import '../controllers/edit_event_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditEventScreen extends GetView<EditEventController> {
  const EditEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Event')),
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
            const SizedBox(height: 24),
            IconButton(
              onPressed: controller.onPicture,
              icon: const Icon(Icons.photo),
            ),
            const SizedBox(height: 24),
            IconButton(
              onPressed: controller.onClear,
              icon: const Icon(Icons.clear),
            ),
            Obx(
              () => (controller.image.value == null)
                  ? const Text('no image')
                  : Image.memory(controller.image.value!),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: controller.onEdit,
              child: const Text('Edit Event'),
            ),
          ],
        ),
      ),
    );
  }
}
