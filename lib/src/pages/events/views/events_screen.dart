import 'widgets/dialog_item.dart';
import 'widgets/event_widget.dart';
import '../controllers/events_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventsScreen extends GetView<EventsController> {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomSheet: _bottomSheet(),
        body: RefreshIndicator(
          color: const Color(0xFF6B9080),
          onRefresh: () => controller.getAllEvents(),
          child: Column(
            children: [
              _appBar(),
              Expanded(child: _events()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bottomSheet() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(child: _searchBar()),
          const SizedBox(width: 12),
          Obx(() => _openDialog()),
        ],
      ),
    );
  }

  Widget _openDialog() {
    return Badge(
      alignment: const Alignment(0.5, -0.6),
      smallSize: 10,
      isLabelVisible: controller.filtered.value,
      child: IconButton(
        onPressed: () => controller.showDialog(dialog),
        icon: const Icon(Icons.menu),
      ),
    );
  }

  Widget _searchBar() {
    return TextField(
      onChanged: controller.onSearch,
      controller: controller.searchController,
      decoration: InputDecoration(
        hintText: 'Search',
        isDense: true,
        contentPadding: const EdgeInsets.all(8),
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _events() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 60),
      child: Obx(
        () => ListView.separated(
          itemCount: controller.events.length,
          itemBuilder: (_, index) => EventWidget(
            event: controller.events[index],
            bookmarked: controller.bookmarkedEvents,
            onView: () => controller.onViewEvent(controller.events[index].id),
            onBookmark: () =>
                controller.onBookmark(controller.events[index].id),
          ),
          separatorBuilder: (_, __) => const SizedBox(height: 12),
        ),
      ),
    );
  }

  Widget _appBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Events',
            style: TextStyle(
              fontSize: 24,
              color: Color(0xFF1F322A),
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: controller.onMyEvents,
            icon: const Icon(Icons.event_outlined),
            tooltip: 'My Events',
          ),
          IconButton(
            onPressed: controller.onBookmarks,
            icon: const Icon(Icons.bookmark_added_outlined),
            tooltip: 'Bookmarks',
          ),
          IconButton(
            onPressed: controller.onLogout,
            icon: const Icon(Icons.settings_outlined),
            tooltip: 'Setting',
          ),
        ],
      ),
    );
  }

  Widget get dialog {
    return Dialog(
      backgroundColor: const Color(0xFFF6FFF8),
      insetPadding: const EdgeInsets.symmetric(vertical: 64, horizontal: 32),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        child: Obx(
          () => SizedBox(
            height: 350,
            width: 400,
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: Get.back,
                      icon: const Icon(Icons.arrow_back),
                    ),
                    const SizedBox(width: 6),
                    const Text('Back', style: TextStyle(fontSize: 18)),
                  ],
                ),
                const SizedBox(height: 12),
                DialogItem(
                  isActive: controller.isLimited.value,
                  onChanged: (v) => controller.isLimited.toggle(),
                  title: 'Price Limitaition',
                ),
                _slider(),
                Text('from ${controller.minPrice} to ${controller.maxPrice}'),
                const SizedBox(height: 6),
                DialogItem(
                  isActive: controller.isFilled.value,
                  onChanged: (v) => controller.isFilled.toggle(),
                  title: 'not Filled',
                ),
                const SizedBox(height: 6),
                DialogItem(
                  isActive: controller.isExpired.value,
                  onChanged: (v) => controller.isExpired.toggle(),
                  title: 'not Expired',
                ),
                const SizedBox(height: 6),
                DialogItem(
                  isActive: controller.isSort.value,
                  onChanged: (v) => controller.isSort.toggle(),
                  title: 'Sort By Date',
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
        child: const Text(
          'Filter',
          style: TextStyle(
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
        child: const Text(
          'Reset',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFFF6FFF8),
          ),
        ),
      ),
    );
  }
}
