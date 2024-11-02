class AddEventDto {
  int makerId;
  String title;
  String description;
  // DateTime.parse('year-month-day hour:minute:secound')
  // day,month,year should have two digits
  String dateTime;
  int capacity;
  double price;
  int attendent;
  String? imageBase64 = '';
  bool filled = false;

  AddEventDto({
    required this.makerId,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.capacity,
    required this.price,
    required this.attendent,
    this.imageBase64,
  });

  Map<String, dynamic> toJason() => {
        "makerId": makerId,
        "title": title,
        "description": description,
        "dateTime": dateTime,
        "capacity": capacity,
        "price": price,
        "attendent": attendent,
        "image": imageBase64,
        "filled": filled,
      };
}
