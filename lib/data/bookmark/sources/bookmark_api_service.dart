import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:lecognition/core/constant/api_urls.dart';
import 'package:lecognition/core/network/dio_client.dart';
import 'package:lecognition/service_locator.dart';

abstract class BookmarkApiService {
  Future<Either> getBookmarkedDiseases();
}

class BookmarkApiServiceImpl extends BookmarkApiService {
  @override
  Future<Either> getBookmarkedDiseases() async {
    try {
      var response = await sl<DioClient>().get(
        ApiUrls.bookmarkByUser,
      );
      return Right(response.data);
    } on DioException catch (error) {
      return Left(error.response!.data["message"]);
    }
  }
}