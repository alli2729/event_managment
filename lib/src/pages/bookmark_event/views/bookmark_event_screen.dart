import '../controllers/bookmark_event_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widgets/event_widget.dart';

class BookmarkEventScreen extends GetView<BookmarkEventController> {
  const BookmarkEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bookmarks")),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(child: _searchBar()),
              const SizedBox(width: 12),
              IconButton(
                onPressed: () => controller.showDialog(dialog),
                icon: const Icon(Icons.menu),
              ),
            ],
          ),
          Expanded(
            child: Obx(
              () => ListView.separated(
                itemCount: controller.bookmarkedEvents.length,
                itemBuilder: (context, index) => EventWidget(
                  event: controller.bookmarkedEvents[index],
                  bookmarked: controller.bookmarkedEvents,
                  onBookmark: () => controller.onBookmark(
                    eventId: controller.bookmarkedEvents[index].id,
                  ),
                  onView: () {},
                ),
                separatorBuilder: (context, index) => const Divider(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _searchBar() {
    return TextField(
      onChanged: controller.onSearch,
      controller: controller.searchController,
      decoration: InputDecoration(
        hintText: 'Search',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget get dialog {
    return Dialog.fullscreen(
      child: Obx(
        () => Column(
          children: [
            CheckboxListTile(
              value: controller.isLimited.value,
              onChanged: (v) => controller.isLimited.toggle(),
              title: const Text('Price Limitaition'),
            ),
            RangeSlider(
              divisions: 500,
              min: controller.min,
              max: controller.max,
              values: controller.priceLimits.value,
              onChanged: (controller.isLimited.value)
                  ? controller.onPriceChanged
                  : null,
            ),
            Text('from ${controller.minPrice} to ${controller.maxPrice}'),
            CheckboxListTile(
              value: controller.isFilled.value,
              onChanged: (v) => controller.isFilled.toggle(),
              title: const Text('not Filled'),
            ),
            CheckboxListTile(
              value: controller.isExpired.value,
              onChanged: (v) => controller.isExpired.toggle(),
              title: const Text('not Expired'),
            ),
            CheckboxListTile(
              value: controller.isSort.value,
              onChanged: (v) => controller.isSort.toggle(),
              title: const Text('Sort By Date'),
            ),
            IconButton(
              onPressed: Get.back,
              icon: const Icon(Icons.cancel),
            ),
            ElevatedButton(
              onPressed: () => Get.back(result: true),
              child: const Text('Filter'),
            ),
            ElevatedButton(
              onPressed: controller.onResetFilters,
              child: const Text('Reset Filters'),
            )
          ],
        ),
      ),
    );
  }
}
