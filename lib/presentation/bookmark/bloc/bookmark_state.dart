import 'package:lecognition/domain/bookmark/entities/bookmark.dart';

abstract class BookmarkState {}

class BookmarkedDiseasesLoading extends BookmarkState {}

class BookmarkedDiseasesLoaded extends BookmarkState {
  final List<BookmarkEntity> bookmarkedDiseases;
  BookmarkedDiseasesLoaded({required this.bookmarkedDiseases});
}

class BookmarkedDiseasesFailureLoad extends BookmarkState {
  final String errorMessage;
  BookmarkedDiseasesFailureLoad({required this.errorMessage});
}