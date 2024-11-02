import 'widgets/event_widget.dart';
import '../controllers/events_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventsScreen extends GetView<EventsController> {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Events'),
        actions: [
          TextButton(
            onPressed: controller.onLogout,
            child: const Text('Logout'),
          )
        ],
      ),
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
                itemCount: controller.events.length,
                itemBuilder: (_, index) => EventWidget(
                  event: controller.events[index],
                  onView: () =>
                      controller.onViewEvent(controller.events[index].id),
                ),
                separatorBuilder: (_, __) => const Divider(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: controller.onMyEvents,
            child: const Text('My Events'),
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
            const Text('Price limitation'),
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
