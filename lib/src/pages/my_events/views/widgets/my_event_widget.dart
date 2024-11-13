import 'package:get/get.dart';
import '../../../../../generated/locales.g.dart';
import '../../models/event_model.dart';
import 'package:flutter/material.dart';

class MyEventWidget extends StatelessWidget {
  const MyEventWidget({
    super.key,
    required this.event,
    required this.onRemove,
    required this.onEdit,
    required this.removeLoading,
  });

  final EventModel event;
  final RxMap<int, bool> removeLoading;
  final void Function() onRemove;
  final void Function() onEdit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onEdit,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xFFF6FFF8),
            boxShadow: const [
              BoxShadow(
                color: Color(0xFFD0DED6),
                spreadRadius: 1,
                blurRadius: 1,
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
            child: Row(
              children: [
                _remvoeIcon(),
                // const SizedBox(width: 6),
                _avatar(),
                const SizedBox(width: 10),
                _title(context),
                const Spacer(),
                _priceDate(),
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

  Widget _title(BuildContext context) {
    return SizedBox(
      width: (pageWidth(context) / 3),
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
          )
        ],
      ),
    );
  }

  Widget _priceDate() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${event.price} ${LocaleKeys.event_managment_app_my_event_page_t.tr}',
          style: const TextStyle(
            fontSize: 14,
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
        const SizedBox(height: 6),
        Text(
          '${event.attendees} / ${event.capacity}',
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _remvoeIcon() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Obx(
          () => (isRemoveLoading)
              ? Transform.scale(
                  scale: 0.4,
                  child: const CircularProgressIndicator(
                    color: Colors.red,
                  ),
                )
              : GestureDetector(
                  onTap: onRemove,
                  child: const Icon(
                    Icons.cancel,
                    color: Colors.red,
                  ),
                ),
        ),
      ],
    );
  }

  double pageWidth(BuildContext context) {
    return MediaQuery.sizeOf(context).width;
  }

  String get date =>
      '${event.dateTime.year}/${event.dateTime.month}/${event.dateTime.day}';
  String get time => '${event.dateTime.hour} : ${event.dateTime.minute}';

  bool get isRemoveLoading => removeLoading[event.id] ?? false;
}
