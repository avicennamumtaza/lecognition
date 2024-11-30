import 'package:dartz/dartz.dart';
import 'package:lecognition/data/diagnozer/models/get_diagnoze_result_params.dart';

abstract class DiagnozerRepository {
  Future<Either> getDiagnosis(GetDiagnosisParams params);
}