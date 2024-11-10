import 'package:lecognition/domain/bookmark/entities/bookmark.dart';

class BookmarkMapper {
  static BookmarkEntity toEntity(BookmarkEntity data) {
    return BookmarkEntity(
      id: data.id,
      disease: data.disease,
      date: data.date,
      user: data.user,
    );
  }
}
