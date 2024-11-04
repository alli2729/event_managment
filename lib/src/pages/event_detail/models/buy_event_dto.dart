class BuyEventDto {
  int attendees;
  bool? filled;

  BuyEventDto({
    required this.attendees,
    this.filled,
  });

  Map<String, dynamic> toJason() => {
        "attendees": attendees,
        "filled": filled,
      };
}
