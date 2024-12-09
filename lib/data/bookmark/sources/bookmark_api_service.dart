import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:lecognition/core/constant/api_urls.dart';
import 'package:lecognition/core/network/dio_client.dart';
import 'package:lecognition/data/bookmark/models/bookmark_disease_params.dart';
import 'package:lecognition/data/bookmark/models/unbookmark_disease_params.dart';
import 'package:lecognition/service_locator.dart';

abstract class BookmarkApiService {
  Future<Either> getBookmarkedDiseases();
  Future<Either> bookmarkDisease(BookmarkDiseaseParams params);
  Future<Either> unbookmarkDisease(UnbookmarkDiseaseParams params);
}

class BookmarkApiServiceImpl extends BookmarkApiService {
  @override
  Future<Either> getBookmarkedDiseases() async {
    try {
      var response = await sl<DioClient>().get(
        ApiUrls.bookmarkByUser,
        options: Options(
          validateStatus: (status) {
            // Mengizinkan semua status code agar tidak dianggap sebagai exception
            return status != null && status <= 500;
          },
        ),
      );
      if (response.statusCode! >= 400) {
        print(response.data);
        return Left(response.data.toString());
      }
      return Right(response.data);
    } on DioException catch (error) {
      return Left(error.response!.data["message"]);
    }
  }

  @override
  Future<Either> bookmarkDisease(BookmarkDiseaseParams params) async {
    try {
      var response = await sl<DioClient>().post(
        ApiUrls.bookmarking,
        data: params.toMap(),
        options: Options(
          validateStatus: (status) {
            // Mengizinkan semua status code agar tidak dianggap sebagai exception
            return status != null && status <= 500;
          },
        ),
      );
      if (response.statusCode! >= 400) {
        print(response.data);
        return Left(response.data.toString());
      }
      print('Response: ${response.data}');
      if (response.statusCode == 201) {
        return Right(response.data);
      } else {
        return Left(
          'Terjadi kesalahan ${response.data} dengan status code ${response.statusCode}',
        );
      }
    } on DioException catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either> unbookmarkDisease(UnbookmarkDiseaseParams params) async {
    try {
      var response = await sl<DioClient>().delete(
        ApiUrls.bookmarking + "/${params.bookmarkId.toString()}",
      );
      print(response);
      return Right(response.toString());
    } on DioException catch (error) {
      return Left(error);
    }
  }
}
