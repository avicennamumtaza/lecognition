import 'package:dartz/dartz.dart';
import 'package:lecognition/common/helper/mapper/diagnosis_mapper.dart';
import 'package:lecognition/data/diagnozer/models/get_diagnoze_result_params.dart';
import 'package:lecognition/data/diagnozer/sources/diagnozer_api_service.dart';
import 'package:lecognition/domain/diagnozer/entities/diagnosis.dart';
import 'package:lecognition/domain/diagnozer/repositories/diagnozer.dart';
import 'package:lecognition/service_locator.dart';

class DiagnozerRepositoryImpl extends DiagnozerRepository {
  @override
  Future<Either> getDiagnosis(GetDiagnosisParams params) async {
    var data = await sl<DiagnozerApiService>().getDiagnosis(params);
    var resolvedData = await data;
    return resolvedData.fold(
      (error) {
        return Left(error);
      },
      (data) async {
        print("Resulting $data");
        // final bookmarked = DiagnozerMapper.toEntityWithoutForeign(
        //   BookmarkEntityWithoutForeign.fromJson(data),
        // );
        // print("Resultingggg $bookmarked");
        final dataEntity = DiagnosisEntity.fromJson(data);
        print('Resultingggggg ${dataEntity}');
        return Right(dataEntity);
      },
    );
  }
}
