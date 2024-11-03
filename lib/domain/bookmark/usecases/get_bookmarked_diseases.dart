import 'package:dartz/dartz.dart';
import 'package:lecognition/core/usecase/usecase.dart';
import 'package:lecognition/domain/bookmark/repositories/bookmark.dart';
import 'package:lecognition/service_locator.dart';

class GetBookmarkedDiseasesUseCase extends Usecase<Either, dynamic> {
  @override
  Future<Either> call({params}) async {
    return await sl<BookmarkRepository>().getBookmarkedDiseases();
  }
}