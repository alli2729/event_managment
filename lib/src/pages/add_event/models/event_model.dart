import 'dart:convert';
import 'dart:typed_data';

class EventModel {
  int id;
  int makerId;
  String title;
  String description;
  // DateTime.parse('year-month-day hour:minute:secound')
  // day,month,year should have two digits
  DateTime dateTime;
  int capacity;
  double price;
  int? attendees = 0;
  String? imageBase64;
  Uint8List? image;
  bool filled;

  EventModel({
    required this.id,
    required this.makerId,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.capacity,
    required this.price,
    required this.filled,
    this.attendees,
    this.imageBase64,
  }) {
    image = base64Decode(imageBase64!);
  }

  factory EventModel.fromJason(Map<String, dynamic> json) {
    final DateTime dateTime = DateTime.parse(json["dateTime"]);
    final double price = double.parse('${json["price"]}');
    return EventModel(
      id: json["id"],
      makerId: json["makerId"],
      title: json["title"],
      description: json["description"],
      dateTime: dateTime,
      capacity: json["capacity"],
      price: price,
      attendees: json["attendees"],
      imageBase64: json["image"],
      filled: json["filled"],
    );
  }
}
