import 'widgets/buy_counter.dart';
import '../controllers/event_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventDetailScreen extends GetView<EventDetailController> {
  const EventDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Event Detail')),
      body: Center(
        child: Obx(
          () => Column(
            children: [
              Obx(
                () => CircleAvatar(
                  child: (controller.image.value == null)
                      ? const Icon(Icons.person)
                      : Image.memory(controller.image.value!),
                ),
              ),
              const SizedBox(height: 12),
              Text(controller.event.value.title),
              const SizedBox(height: 12),
              Text(controller.event.value.description),
              const SizedBox(height: 12),
              Text(controller.event.value.dateTime.toString()),
              const SizedBox(height: 12),
              Text(controller.event.value.price.toString()),
              const SizedBox(height: 12),
              Text(controller.event.value.capacity.toString()),
              const SizedBox(height: 12),
              Text(controller.event.value.attendent.toString()),
              const SizedBox(height: 12),
              (controller.notFilled)
                  ? BuyCounter(
                      minValue: 1,
                      maxValue: controller.maxValue,
                      onChanged: controller.onBuyChange,
                    )
                  : const Text('This Event is Filled'),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: controller.onBuyEvent,
                child: const Text('Buy Event'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
