import 'package:lecognition/domain/diagnozer/entities/diagnosis.dart';

abstract class DiagnosisState {}

class DiagnosisLoading extends DiagnosisState {}

class DiagnosisLoaded extends DiagnosisState {
  final DiagnosisEntity diagnosis;
  DiagnosisLoaded({required this.diagnosis});
}

class DiagnosisFailureLoad extends DiagnosisState {
  final String errorMessage;
  DiagnosisFailureLoad({required this.errorMessage});
}