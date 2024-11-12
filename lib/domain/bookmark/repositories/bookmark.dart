import 'package:dartz/dartz.dart';
import 'package:lecognition/data/bookmark/models/bookmark_disease_params.dart';
import 'package:lecognition/data/bookmark/models/unbookmark_disease_params.dart';

abstract class BookmarkRepository {
  Future<Either> getBookmarkedDiseases();
  Future<Either> bookmarkDisease(BookmarkDiseaseParams params);
  Future<Either> unbookmarkDisease(UnbookmarkDiseaseParams params);
}