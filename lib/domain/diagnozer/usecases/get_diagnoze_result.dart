import 'package:dartz/dartz.dart';
import 'package:lecognition/core/usecase/usecase.dart';
import 'package:lecognition/data/diagnozer/models/get_diagnoze_result_params.dart';
import 'package:lecognition/domain/diagnozer/repositories/diagnozer.dart';
import 'package:lecognition/service_locator.dart';

class GetDiagnosisUseCase extends Usecase<Either, GetDiagnosisParams> {

  @override
  Future<Either> call({GetDiagnosisParams? params}) async {
    return await sl<DiagnozerRepository>().getDiagnosis(params!);
  }
}
