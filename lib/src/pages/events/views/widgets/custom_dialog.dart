import '../../controllers/events_controller.dart';
import '../../../../../generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dialog_item.dart';

class CustomDialog extends GetView<EventsController> {
  const CustomDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFFF6FFF8),
      insetPadding: const EdgeInsets.symmetric(vertical: 64, horizontal: 32),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        child: Obx(
          () => Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: Get.back,
                    icon: const Icon(Icons.arrow_back),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    LocaleKeys.event_managment_app_dialog_back.tr,
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              DialogItem(
                isActive: controller.isLimited.value,
                onChanged: (v) => controller.isLimited.toggle(),
                title: LocaleKeys.event_managment_app_dialog_price_limit.tr,
              ),
              _slider(),
              Text(limitation),
              const SizedBox(height: 6),
              DialogItem(
                isActive: controller.isFilled.value,
                onChanged: (v) => controller.isFilled.toggle(),
                title: LocaleKeys.event_managment_app_dialog_not_filled.tr,
              ),
              const SizedBox(height: 6),
              DialogItem(
                isActive: controller.isExpired.value,
                onChanged: (v) => controller.isExpired.toggle(),
                title: LocaleKeys.event_managment_app_dialog_not_expired.tr,
              ),
              const SizedBox(height: 6),
              DialogItem(
                isActive: controller.isSort.value,
                onChanged: (v) => controller.isSort.toggle(),
                title: LocaleKeys.event_managment_app_dialog_sort_by_date.tr,
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _resetButton(),
                  const SizedBox(width: 6),
                  _fillterButton(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _slider() {
    return RangeSlider(
      activeColor: const Color(0xFF2B4D3E),
      divisions: 500,
      min: controller.min,
      max: controller.max,
      values: controller.priceLimits.value,
      onChanged:
          (controller.isLimited.value) ? controller.onPriceChanged : null,
    );
  }

  Widget _fillterButton() {
    return GestureDetector(
      onTap: () => Get.back(result: true),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(0xFF6B9080),
        ),
        child: Text(
          LocaleKeys.event_managment_app_dialog_filter.tr,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFFF6FFF8),
          ),
        ),
      ),
    );
  }

  Widget _resetButton() {
    return GestureDetector(
      onTap: controller.onResetFilters,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(0xFFF48C8C),
        ),
        child: Text(
          LocaleKeys.event_managment_app_dialog_reset.tr,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFFF6FFF8),
          ),
        ),
      ),
    );
  }

  String get limitation {
    return '${LocaleKeys.event_managment_app_dialog_from.tr} ${controller.minPrice} ${LocaleKeys.event_managment_app_dialog_to.tr} ${controller.maxPrice}';
  }
}
