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
  
  static BookmarkEntityWithoutForeign toEntityWithoutForeign(BookmarkEntityWithoutForeign data) {
    return BookmarkEntityWithoutForeign(
      id: data.id,
      disease: data.disease,
      date: data.date,
      user: data.user,
    );
  }
}
