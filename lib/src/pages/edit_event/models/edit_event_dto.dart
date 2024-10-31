class EditEventDto {
  int makerId;
  String title;
  String description;
  // DateTime.parse('year-month-day hour:minute:secound')
  // day,month,year should have two digits
  String dateTime;
  int capacity;
  double price;

  EditEventDto({
    required this.makerId,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.capacity,
    required this.price,
  });

  Map<String, dynamic> toJason() => {
      "makerId": makerId,
      "title": title,
      "description": description,
      "dateTime": dateTime,
      "capacity": capacity,
      "price": price,
    };
}
