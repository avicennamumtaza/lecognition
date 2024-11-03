import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:lecognition/core/constant/api_urls.dart';
import 'package:lecognition/core/network/dio_client.dart';
import 'package:lecognition/data/bookmark/models/get_bookmarked_diseases_params.dart';
import 'package:lecognition/service_locator.dart';

abstract class BookmarkApiService {
  Future<Either> getBookmarkedDiseases(GetBookmarkedDiseasesParams params);
}

class BookmarkApiServiceImpl extends BookmarkApiService {
  @override
  Future<Either> getBookmarkedDiseases(GetBookmarkedDiseasesParams params) async {
    try {
      var response = await sl<DioClient>().get(
        ApiUrls.getUserById,
        data: params.toMap(),
      );
      return Right(response.data);
    } on DioException catch (error) {
      return Left(error.response!.data["message"]);
    }
  }
}