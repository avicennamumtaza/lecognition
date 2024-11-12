import 'package:dartz/dartz.dart';
import 'package:lecognition/common/helper/mapper/bookmark_mapper.dart';
import 'package:lecognition/data/bookmark/models/bookmark_disease_params.dart';
import 'package:lecognition/data/bookmark/models/unbookmark_disease_params.dart';
import 'package:lecognition/data/bookmark/sources/bookmark_api_service.dart';
import 'package:lecognition/domain/bookmark/entities/bookmark.dart';
import 'package:lecognition/domain/bookmark/repositories/bookmark.dart';
import 'package:lecognition/service_locator.dart';

class BookmarkRepositoryImpl extends BookmarkRepository {
  @override
  Future<Either> unbookmarkDisease(UnbookmarkDiseaseParams params) async {
    var data = await sl<BookmarkApiService>().unbookmarkDisease(params);
    return data.fold(
      (error) {
        return Left(error);
      },
      (data) async {
        return Right(data);
      },
    );
  }

  @override
  Future<Either> bookmarkDisease(BookmarkDiseaseParams params) async {
    var data = await sl<BookmarkApiService>().bookmarkDisease(params);
    return data.fold(
      (error) {
        return Left(error);
      },
      (data) async {
        return Right(data);
      },
    );
  }

  @override
  Future<Either> getBookmarkedDiseases() async {
    var data = await sl<BookmarkApiService>().getBookmarkedDiseases();
    return data.fold(
      (error) {
        return Left(error);
      },
      (data) async {
        final diseases = List.from(data)
            .map(
              (item) => BookmarkMapper.toEntity(
                BookmarkEntity.fromJson(item),
              ),
            )
            .toList();
        return Right(diseases);
      },
    );
  }
}
