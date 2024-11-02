import 'dart:convert';
import 'dart:typed_data';
import 'package:get/get.dart';
import '../models/buy_event_dto.dart';
import '../../../infrastructure/common/utils.dart';
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
    attendent: 0,
  ));

  Rxn<Uint8List> image = Rxn();
  String imageBase64 = '';

  int buyValue = 1;

  // functions
  Future<void> getEventById() async {
    final result = await _repository.getEventById(eventId: eventId);
    result.fold(
      (exception) => Utils.showFailSnackBar(message: exception),
      (event) {
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
    int sendAttendent = event.value.attendent! + buyValue;
    final BuyEventDto dto = BuyEventDto(
      attendent: sendAttendent,
    );

    final result = await _repository.buyEvent(dto: dto, eventId: eventId);
    result.fold(
      (exception) {
        Utils.showFailSnackBar(message: exception);
      },
      (_) {
        Get.back();
      },
    );
  }

  int get maxValue => event.value.capacity - event.value.attendent!;
  bool get notFilled => event.value.capacity != event.value.attendent!;

  @override
  void onInit() {
    super.onInit();
    getEventById();
  }
}
