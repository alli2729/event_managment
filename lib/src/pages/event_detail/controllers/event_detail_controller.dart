import 'dart:convert';
import 'dart:typed_data';
import 'package:get/get.dart';
import '../models/buy_event_dto.dart';
import '../../../infrastructure/utils/utils.dart';
import '../models/event_model.dart';
import '../repositories/event_detail_repository.dart';

class EventDetailController extends GetxController {
  // constructor
  int eventId;
  EventDetailController({required this.eventId});

  // variables
  final _repository = EventDetailRepository();

  Rx<EventModel> event = Rx(EventModel(
    id: 0,
    makerId: 0,
    title: 'title',
    description: 'description',
    dateTime: DateTime(2000),
    capacity: 0,
    price: 0,
    imageBase64: '',
    attendees: 0,
    filled: false,
  ));

  Rxn<Uint8List> image = Rxn();
  String imageBase64 = '';

  int buyValue = 1;

  RxBool isLoading = false.obs;
  RxBool isRetry = false.obs;
  RxBool isBuying = false.obs;

  // functions
  Future<void> getEventById() async {
    isLoading.value = true;
    isRetry.value = false;

    final result = await _repository.getEventById(eventId: eventId);
    result.fold(
      (exception) {
        isLoading.value = false;
        isRetry.value = true;
        Utils.showFailSnackBar(message: exception.tr);
      },
      (event) {
        isLoading.value = false;
        isLoading.value = false;

        this.event.value = event;
        imageBase64 = event.imageBase64!;
        if (imageBase64.isNotEmpty) {
          image.value = base64Decode(imageBase64);
        }
      },
    );
  }

  void onBuyChange(int v) {
    buyValue = v;
  }

  Future<void> onBuyEvent() async {
    isBuying.value = true;

    int sendattendees = event.value.attendees! + buyValue;
    bool filled = false;
    if (sendattendees == event.value.capacity) filled = true;

    final BuyEventDto dto = BuyEventDto(
      attendees: sendattendees,
      filled: filled,
    );

    final result = await _repository.buyEvent(dto: dto, eventId: eventId);
    result.fold(
      (exception) {
        isBuying.value = false;
        Utils.showFailSnackBar(message: exception.tr);
      },
      (_) {
        isBuying.value = false;
        Get.back();
      },
    );
  }

  int get maxValue => event.value.capacity - event.value.attendees!;
  bool get notFilled => event.value.capacity != event.value.attendees!;

  @override
  void onInit() {
    super.onInit();
    getEventById();
  }
}
