import '../controllers/bookmark_event_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widgets/event_widget.dart';

class BookmarkEventScreen extends GetView<BookmarkEventController> {
  const BookmarkEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bookmarked")),
      body: Obx(
        () => ListView.separated(
          itemCount: controller.bookmarkedEvents.length,
          itemBuilder: (context, index) => EventWidget(
            event: controller.bookmarkedEvents[index],
            bookmarked: controller.bookmarkedEvents,
            onBookmark: () => controller.onBookmark(
              eventId: controller.bookmarkedEvents[index].id,
            ),
            onView: () {},
          ),
          separatorBuilder: (context, index) => const Divider(),
        ),
      ),
    );
  }
}
