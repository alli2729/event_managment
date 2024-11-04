import 'widgets/drop_button.dart';
import 'package:flutter/services.dart';
import '../../../infrastructure/common/date_values.dart';
import '../controllers/add_event_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddEventScreen extends GetView<AddEventController> {
  const AddEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: Obx(() => _fab()),
        appBar: AppBar(title: const Text('Add Event')),
        body: Form(
          key: controller.addFormKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Obx(
                () => Column(
                  children: [
                    Obx(() => _image()),
                    const SizedBox(height: 24),
                    _title(),
                    const SizedBox(height: 12),
                    _description(),
                    const SizedBox(height: 12),
                    _price(),
                    const SizedBox(height: 12),
                    _capacity(),
                    const SizedBox(height: 12),
                    Obx(() => _date()),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _fab() {
    return (controller.isLoading.value)
        ? FloatingActionButton(
            backgroundColor: const Color(0xFF2B4D3E),
            shape: const CircleBorder(),
            onPressed: null,
            child: Transform.scale(
              scale: 0.5,
              child: const CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          )
        : FloatingActionButton(
            backgroundColor: const Color(0xFF2B4D3E),
            shape: const CircleBorder(),
            onPressed: controller.onAddEvent,
            child: const Icon(Icons.check, color: Colors.white),
          );
  }

  Widget _image() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        (controller.image.value != null)
            ? IconButton(
                onPressed: controller.onClear,
                icon: const Icon(Icons.clear),
              )
            : const SizedBox(),
        GestureDetector(
          onTap: controller.onPicture,
          child: CircleAvatar(
            backgroundColor: const Color(0xFF2B4D3E),
            radius: 40,
            child: ClipOval(
              child: (controller.image.value == null)
                  ? const Icon(Icons.edit, color: Colors.white)
                  : Image.memory(controller.image.value!),
            ),
          ),
        ),
      ],
    );
  }

  Widget _date() {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: DropButton(
              value: controller.day.value,
              items: DateValues.days,
              onChanged: controller.selectDay,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 1,
            child: DropButton(
              value: controller.month.value,
              items: DateValues.months,
              onChanged: controller.selectMonth,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 1,
            child: DropButton(
              value: controller.year.value,
              items: DateValues.years,
              onChanged: controller.selectYear,
            ),
          ),
        ],
      ),
    );
  }

  Widget _capacity() {
    return TextFormField(
      enabled: (!controller.isLoading.value),
      controller: controller.capacityController,
      validator: controller.validate,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.reduce_capacity),
        labelText: 'Capacity',
        hintText: 'Capacity',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _price() {
    return TextFormField(
      enabled: (!controller.isLoading.value),
      controller: controller.priceController,
      validator: controller.validate,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.price_change),
        labelText: 'Price',
        hintText: 'Price',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _description() {
    return TextFormField(
      enabled: (!controller.isLoading.value),
      controller: controller.descriptionController,
      validator: controller.validate,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.description),
        labelText: 'Description',
        hintText: 'Description',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _title() {
    return TextFormField(
      enabled: (!controller.isLoading.value),
      controller: controller.titleController,
      validator: controller.validate,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.title),
        labelText: 'Title',
        hintText: 'Title',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
