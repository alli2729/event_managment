class BookmarkUserDto {
  List bookmarked;

  BookmarkUserDto({
    required this.bookmarked,
  });

  Map<String, dynamic> toJson() {
    return {
      "bookmarked": bookmarked,
    };
  }
}
