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
          Expanded(
            child: Obx(
              () => ListView.separated(
                itemCount: controller.events.length,
                itemBuilder: (_, index) => EventWidget(
                  event: controller.events[index],
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
}
