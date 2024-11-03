import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:lecognition/core/constant/api_urls.dart';
import 'package:lecognition/core/network/dio_client.dart';
import 'package:lecognition/service_locator.dart';

abstract class DiseaseApiService {
  Future<Either> getAllDiseases();
}

class DiseaseApiServiceImpl extends DiseaseApiService {
  @override
  Future<Either> getAllDiseases() async {
    try {
      var response = await sl<DioClient>().get(
        ApiUrls.getAllDiseases,
      );
      return Right(response.data);
    } on DioException catch (error) {
      return Left(error.response!.data["message"]);
    }
  }
}