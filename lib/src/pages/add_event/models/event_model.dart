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

  EventModel({
    required this.id,
    required this.makerId,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.capacity,
    required this.price,
  });

  factory EventModel.fromJason(Map<String, dynamic> json) {
    return EventModel(
      id: json["id"],
      makerId: json["makerId"],
      title: json["title"],
      description: json["description"],
      dateTime: DateTime.parse(json["dateTime"]),
      capacity: json["capacity"],
      price: json["price"],
    );
  }
}
