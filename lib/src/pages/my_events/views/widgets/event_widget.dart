import 'package:flutter/material.dart';
import '../../models/event_model.dart';

class EventWidget extends StatelessWidget {
  const EventWidget({
    super.key,
    required this.event,
    required this.onEdit,
    required this.onRemove,
  });

  final EventModel event;
  final void Function() onEdit;
  final void Function() onRemove;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          child: (event.image!.isNotEmpty)
              ? Image.memory(event.image!)
              : const Icon(Icons.person),
        ),
        const SizedBox(width: 10),
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
        const Spacer(),
        IconButton(onPressed: onEdit, icon: const Icon(Icons.edit)),
        const SizedBox(width: 10),
        IconButton(onPressed: onRemove, icon: const Icon(Icons.delete))
      ],
    );
  }
}
