import 'package:lecognition/domain/disease/entities/disease.dart';

abstract class DiseaseState {}

class DiseasesLoading extends DiseaseState {}

class DiseasesLoaded extends DiseaseState {
  final List<DiseaseEntity> diseases;
  DiseasesLoaded({required this.diseases});
}

class DiseasesFailureLoad extends DiseaseState {
  final String errorMessage;
  DiseasesFailureLoad({required this.errorMessage});
}