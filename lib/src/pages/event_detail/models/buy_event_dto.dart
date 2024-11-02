class BuyEventDto {
  int attendent;

  BuyEventDto({
    required this.attendent,
  });

  Map<String, dynamic> toJason() => {
        "attendent": attendent,
      };
}
