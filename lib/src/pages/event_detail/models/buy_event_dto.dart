class BuyEventDto {
  int attendent;
  bool? filled;

  BuyEventDto({
    required this.attendent,
    this.filled,
  });

  Map<String, dynamic> toJason() => {
        "attendent": attendent,
        "filled": filled,
      };
}
