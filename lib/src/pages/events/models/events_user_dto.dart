class EventsUserDto {
  List bookmarked;

  EventsUserDto({
    required this.bookmarked,
  });

  Map<String, dynamic> toJson() {
    return {
      "bookmarked": bookmarked,
    };
  }
}
