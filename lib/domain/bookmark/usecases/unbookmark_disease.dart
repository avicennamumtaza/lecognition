import 'package:dartz/dartz.dart';
import 'package:lecognition/core/usecase/usecase.dart';
import 'package:lecognition/data/bookmark/models/unbookmark_disease_params.dart';
import 'package:lecognition/domain/bookmark/repositories/bookmark.dart';
import 'package:lecognition/service_locator.dart';

class UnbookmarkDiseaseUseCase extends Usecase<Either, UnbookmarkDiseaseParams> {
  @override
  Future<Either> call({UnbookmarkDiseaseParams? params}) async {
    return await sl<BookmarkRepository>().unbookmarkDisease(params!);
  }
}