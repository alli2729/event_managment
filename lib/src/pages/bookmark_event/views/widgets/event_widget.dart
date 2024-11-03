import '../../models/event_model.dart';
import 'package:flutter/material.dart';

class EventWidget extends StatelessWidget {
  const EventWidget({
    super.key,
    required this.event,
    required this.onView,
    required this.onBookmark,
    required this.bookmarked,
  });

  final EventModel event;
  final void Function() onView;
  final void Function() onBookmark;
  final List<EventModel> bookmarked;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onView,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: _mainRow(),
      ),
    );
  }

  Widget _mainRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _avatarAndTitle(),
            Text(event.description),
          ],
        ),
        Column(
          children: [
            Text('${event.price} T', style: const TextStyle(fontSize: 16)),
            Text(dateTime),
            Text('${event.attendent} / ${event.capacity}'),
          ],
        ),
        IconButton(
          onPressed: onBookmark,
          icon: const Icon(Icons.bookmark, color: Colors.red),
        ),
      ],
    );
  }

  Widget _avatarAndTitle() {
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          child: (event.image!.isNotEmpty)
              ? Image.memory(event.image!)
              : const Icon(Icons.person),
        ),
        Text(event.title, style: const TextStyle(fontSize: 24))
      ],
    );
  }

  String get dateTime {
    return '${event.dateTime.year}-${event.dateTime.month}-${event.dateTime.day}';
  }

  bool get isBookmarked {
    for (var bookmark in bookmarked) {
      if (bookmark.id == event.id) {
        return true;
      }
    }
    return false;
  }
}
