import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/my_events_controller.dart';
import 'widgets/event_widget.dart';

class MyEventsScreen extends GetView<MyEventsController> {
  const MyEventsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Events')),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(child: _searchBar()),
              const SizedBox(width: 12),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.menu),
              ),
            ],
          ),
          Expanded(
            child: Obx(
              () => ListView.separated(
                itemCount: controller.myEvents.length,
                itemBuilder: (_, index) => EventWidget(
                  event: controller.myEvents[index],
                  onRemove: () => controller.onRemove(
                    eventId: controller.myEvents[index].id,
                  ),
                  onEdit: () => controller.onEdit(
                    eventId: controller.myEvents[index].id,
                  ),
                ),
                separatorBuilder: (_, __) => const Divider(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: controller.addEvent,
            child: const Text('Add Event'),
          )
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
}
