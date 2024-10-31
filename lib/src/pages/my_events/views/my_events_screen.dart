import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/my_events_controller.dart';
import 'widgets/event_widget.dart';

class MyEventsScreen extends GetView<MyEventsController> {
  const MyEventsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => ListView.separated(
          itemCount: controller.myEvents.length,
          itemBuilder: (_, index) => EventWidget(
            event: controller.myEvents[index],
          ),
          separatorBuilder: (_, __) => const Divider(),
        ),
      ),
    );
  }
}
