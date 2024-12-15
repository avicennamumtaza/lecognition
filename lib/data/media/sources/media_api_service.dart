import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:lecognition/core/network/dio_client.dart';
import 'package:lecognition/data/media/models/get_image_params.dart';
import 'package:lecognition/service_locator.dart';

abstract class MediaApiService {
  Future<Either> getImage(GetImageParams params);
}

class MediaApiServiceImpl extends MediaApiService {
  @override
  Future<Either> getImage(GetImageParams params) async {
    try {
      var response = await sl<DioClient>().get(
        "${params.url}",
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
    } catch (error) {
      return Left(error.toString());
    }
  }
}