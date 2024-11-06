import 'package:number_picker/number_picker.dart';
import '../../../../generated/locales.g.dart';
import '../controllers/event_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventDetailScreen extends GetView<EventDetailController> {
  const EventDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomSheet: Obx(
          () =>
              (controller.isLoading.value) ? const SizedBox() : _bottomSheet(),
        ),
        appBar: AppBar(
            title: Text(
          LocaleKeys.event_managment_app_detail_page_event_detail.tr,
        )),
        body: Obx(() => _pageContent()),
      ),
    );
  }

  Widget _pageContent() {
    if (controller.isLoading.value) {
      return _loading();
    }
    if (controller.isRetry.value) {
      return _retry();
    }
    return _body();
  }

  Widget _retry() {
    return Center(
      child: IconButton(
        onPressed: controller.getEventById,
        icon: const Icon(Icons.replay_circle_filled_outlined),
        color: const Color(0xFF2B4D3E),
      ),
    );
  }

  Widget _loading() {
    return const Center(
      child: CircularProgressIndicator(
        color: Color(0xFF2B4D3E),
      ),
    );
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _image(),
          const SizedBox(height: 16),
          _title(),
          const SizedBox(height: 16),
          _box(),
        ],
      ),
    );
  }

  Widget _box() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFF6FFF8),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFD0DED6),
            spreadRadius: 1,
            blurRadius: 1,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${LocaleKeys.event_managment_app_detail_page_opening_date.tr} $dateTime',
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 16),
          Text(_description, style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 16),
          Text(_priceToman, style: const TextStyle(fontSize: 18)),
        ],
      ),
    );
  }

  Widget _bottomSheet() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        // color: const Color(0xFFD0DED6),
      ),
      child: (controller.notFilled)
          ? Row(
              // mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(_cap, style: const TextStyle(fontSize: 16)),
                const Spacer(),
                NumberPicker(
                  numberColor: const Color(0xFF2D5845),
                  minValue: 1,
                  maxValue: controller.maxValue,
                  onChanged: controller.onBuyChange,
                ),
                const SizedBox(width: 10),
                _buyButton(),
              ],
            )
          : Container(
              alignment: Alignment.center,
              width: double.infinity,
              child: Text(
                LocaleKeys.event_managment_app_detail_page_event_is_filled.tr,
                style: const TextStyle(fontSize: 20),
              ),
            ),
    );
  }

  Widget _buyButton() {
    return GestureDetector(
      onTap: (controller.isBuying.value) ? null : controller.onBuyEvent,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: const Color(0xFF2D5845),
        ),
        child: (controller.isBuying.value)
            ? Transform.scale(
                scale: 0.5,
                child: const CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : Text(
                LocaleKeys.event_managment_app_detail_page_buy.tr,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }

  Widget _image() {
    return Obx(
      () => CircleAvatar(
        backgroundColor: const Color(0xFFA4C3B2),
        radius: 55,
        child: ClipOval(
          child: (controller.image.value == null)
              ? const Icon(Icons.event, color: Color(0xFFEAF4F4))
              : Image.memory(controller.image.value!),
        ),
      ),
    );
  }

  Widget _title() {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFF6FFF8),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFD0DED6),
            spreadRadius: 1,
            blurRadius: 1,
          )
        ],
      ),
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Text(
          _titleText,
          style: const TextStyle(fontSize: 28),
        ),
      ),
    );
  }

  String get _priceToman =>
      '${LocaleKeys.event_managment_app_detail_page_price.tr} $_price ${LocaleKeys.event_managment_app_detail_page_toman.tr}';
  String get _cap =>
      '${controller.event.value.attendees} / ${controller.event.value.capacity}';
  String get _description => controller.event.value.description;
  String get _titleText => controller.event.value.title;
  String get _price => controller.event.value.price.toString();
  String get dateTime =>
      '${controller.event.value.dateTime.year}/${controller.event.value.dateTime.month}/${controller.event.value.dateTime.day}';
}
