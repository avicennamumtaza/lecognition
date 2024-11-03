import 'package:dartz/dartz.dart';

abstract class BookmarkRepository {
  Future<Either> getBookmarkedDiseases();
}