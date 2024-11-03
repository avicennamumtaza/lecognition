import 'package:dartz/dartz.dart';
import 'package:lecognition/data/disease/sources/disease_api_service.dart';
import 'package:lecognition/domain/disease/repositories/disease.dart';
import 'package:lecognition/service_locator.dart';

class DiseaseRepositoryImpl extends DiseaseRepository {
  @override
  Future<Either> getAllDiseases() async {
    var data = await sl<DiseaseApiService>().getAllDiseases();
    return data.fold(
      (error) {
        return Left(error);
      },
      (data) async {
        // final SharedPreferences sharedPreferences =
        //     await SharedPreferences.getInstance();
        // sharedPreferences.setString('access_token', data['access']);
        return Right(data);
      },
    );
  }
}