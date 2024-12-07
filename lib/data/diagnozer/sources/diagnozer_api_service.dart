import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:lecognition/core/constant/api_urls.dart';
import 'package:lecognition/core/network/dio_client.dart';
import 'package:lecognition/data/diagnozer/models/get_diagnoze_result_params.dart';
import 'package:lecognition/service_locator.dart';

abstract class DiagnozerApiService {
  Future<Either> getDiagnosis(GetDiagnosisParams params);
}

class DiagnozerApiServiceImpl extends DiagnozerApiService {
  @override
  Future<Either> getDiagnosis(GetDiagnosisParams params) async {
    try {
      if (params.imageFile.path.isEmpty) {
        return Left("Image file is empty");
      } else {
        FormData formData = FormData.fromMap({
          "img": await MultipartFile.fromFile(params.imageFile.path),
          "datetime": 123456,
        });
        print("formData: $formData");
        var response = await sl<DioClient>().post(
          ApiUrls.scan,
          data: formData,
        );
        print("RESPONSE DATA ${response.data}");
        return Right(response.data);
      }
    } on DioException catch (error) {
      return Left(error.response!.data["message"]);
    }
  }
}
