import 'package:flutter/services.dart';
import '../../../../generated/locales.g.dart';
import '../../../infrastructure/common/date_values.dart';
import '../controllers/edit_event_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widgets/drop_button.dart';

class EditEventScreen extends GetView<EditEventController> {
  const EditEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: Obx(() => _fab()),
        appBar: AppBar(
            title: Text(
          LocaleKeys.event_managment_app_edit_event_page_edit_event.tr,
        )),
        body: Form(
          key: controller.addFormKey,
          child: Obx(() => _pageContent()),
        ),
      ),
    );
  }

  Widget _pageContent() {
    return (controller.isFetching.value) ? _fetching() : _body();
  }

  Widget _fetching() {
    return Center(
      child: CircularProgressIndicator(
        color: const Color(0xFF2B4D3E),
        semanticsLabel:
            LocaleKeys.event_managment_app_edit_event_page_fetching_data.tr,
      ),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
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
            onPressed: controller.onEdit,
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
          onTap: (controller.isLoading.value) ? null : controller.onPicture,
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
        labelText: LocaleKeys.event_managment_app_edit_event_page_capacity.tr,
        hintText: LocaleKeys.event_managment_app_edit_event_page_capacity.tr,
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
        labelText: LocaleKeys.event_managment_app_edit_event_page_price.tr,
        hintText: LocaleKeys.event_managment_app_edit_event_page_price.tr,
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
        labelText:
            LocaleKeys.event_managment_app_edit_event_page_description.tr,
        hintText: LocaleKeys.event_managment_app_edit_event_page_description.tr,
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
        labelText: LocaleKeys.event_managment_app_edit_event_page_title.tr,
        hintText: LocaleKeys.event_managment_app_edit_event_page_title.tr,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
