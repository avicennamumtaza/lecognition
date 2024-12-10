import 'package:dartz/dartz.dart';
import 'package:lecognition/common/helper/mapper/disease_mapper.dart';
import 'package:lecognition/data/disease/sources/disease_api_service.dart';
import 'package:lecognition/domain/disease/entities/disease.dart';
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
        final diseases = List.from(data)
            .map(
              (item) => DiseaseMapper.toEntity(
                DiseaseEntity.fromJson(item),
              ),
            )
            .toList();
        return Right(diseases);
      },
    );
  }
}
