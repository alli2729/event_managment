import '../../../../../generated/locales.g.dart';
import 'package:get/get.dart';
import '../../models/event_model.dart';
import 'package:flutter/material.dart';

class EventWidget extends StatelessWidget {
  const EventWidget({
    super.key,
    required this.event,
    required this.onView,
    required this.onBookmark,
    required this.bookmarked,
    required this.bookmarkLoading,
  });

  final EventModel event;
  final RxList bookmarked;
  final RxMap<int, bool> bookmarkLoading;
  final void Function() onView;
  final void Function() onBookmark;

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
                title(context),
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

  Widget title(BuildContext context) {
    return SizedBox(
      width: (pageWidth(context) / 3.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            event.title,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            event.description,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget priceDate() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${event.price} ${LocaleKeys.event_managment_app_events_page_t.tr}',
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF41C88E),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          date,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFFA4C3B2),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          time,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFFA4C3B2),
          ),
        ),
      ],
    );
  }

  Widget iconNumber() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _bookmarkIcon(),
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

  Widget _bookmarkIcon() {
    return Obx(
      () => (isBookmarkLoading)
          ? Transform.scale(
              scale: 0.4,
              child: const CircularProgressIndicator(),
            )
          : GestureDetector(
              onTap: onBookmark,
              child: (isBookmarked)
                  ? const Icon(Icons.bookmark, color: Colors.red)
                  : const Icon(Icons.bookmark_outline),
            ),
    );
  }

  double pageWidth(BuildContext context) {
    return MediaQuery.sizeOf(context).width;
  }

  String get date =>
      '${event.dateTime.year}/${event.dateTime.month}/${event.dateTime.day}';
  String get time => '${event.dateTime.hour} : ${event.dateTime.minute}';

  bool get isBookmarked => (bookmarked.contains(event.id));
  bool get isBookmarkLoading => bookmarkLoading[event.id] ?? false;
}
