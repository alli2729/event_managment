import '../../models/event_model.dart';
import 'package:flutter/material.dart';

class BookmarkEventWidget extends StatelessWidget {
  const BookmarkEventWidget({
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: InkWell(
        onTap: onView,
        borderRadius: BorderRadius.circular(10),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xFFF6FFF8),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(255, 208, 222, 214),
                spreadRadius: 1,
                blurRadius: 1,
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
            child: Row(
              children: [
                _avatar(),
                const SizedBox(width: 10),
                title(),
                const Spacer(),
                priceDate(),
                const SizedBox(width: 12),
                iconNumber(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _avatar() {
    return CircleAvatar(
      backgroundColor: const Color(0xFFEAF4F4),
      radius: 30,
      child: (event.image!.isNotEmpty)
          ? ClipOval(child: Image.memory(event.image!))
          : const Icon(Icons.event, color: Color(0xFFA4C3B2)),
    );
  }

  Widget title() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          event.title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          event.description,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        )
      ],
    );
  }

  Widget priceDate() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${event.price} T',
          style: const TextStyle(
            fontSize: 18,
            color: Color(0xFF41C88E),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          dateTime,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFFA4C3B2),
          ),
        )
      ],
    );
  }

  Widget iconNumber() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onBookmark,
          child: (isBookmarked)
              ? const Icon(Icons.bookmark, color: Colors.red)
              : const Icon(Icons.bookmark_outline),
        ),
        const SizedBox(height: 12),
        Text(
          '${event.attendees} / ${event.capacity}',
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        )
      ],
    );
  }

  String get dateTime =>
      '${event.dateTime.year}/${event.dateTime.month}/${event.dateTime.day}';

  bool get isBookmarked {
    for (var bookmark in bookmarked) {
      if (bookmark.id == event.id) {
        return true;
      }
    }
    return false;
  }
}
