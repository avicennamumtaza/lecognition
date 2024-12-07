import 'package:dartz/dartz.dart';
import 'package:lecognition/core/usecase/usecase.dart';
import 'package:lecognition/data/bookmark/models/bookmark_disease_params.dart';
import 'package:lecognition/domain/bookmark/repositories/bookmark.dart';
import 'package:lecognition/service_locator.dart';

class BookmarkDiseaseUseCase extends Usecase<Either, BookmarkDiseaseParams> {
  @override
  Future<Either> call({BookmarkDiseaseParams? params}) async {
    return await sl<BookmarkRepository>().bookmarkDisease(params!);
  }
}