import '../../models/event_model.dart';
import 'package:flutter/material.dart';

class EventWidget extends StatelessWidget {
  const EventWidget({
    super.key,
    required this.event,
    required this.onView,
  });

  final EventModel event;
  final void Function() onView;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          child: (event.image!.isNotEmpty)
              ? Image.memory(event.image!)
              : const Icon(Icons.person),
        ),
        Text(event.id.toString()),
        const SizedBox(width: 10),
        Text(event.makerId.toString()),
        const SizedBox(width: 10),
        Text(event.title),
        const SizedBox(width: 10),
        Text(event.description),
        const SizedBox(width: 10),
        Text(event.dateTime.year.toString()),
        const SizedBox(width: 10),
        Text(event.capacity.toString()),
        const SizedBox(width: 10),
        Text('att: ${event.attendent.toString()}'),
        const Spacer(),
        IconButton(
          onPressed: onView,
          icon: const Icon(Icons.event),
        ),
      ],
    );
  }
}
