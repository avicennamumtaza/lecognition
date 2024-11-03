import 'package:dartz/dartz.dart';

abstract class DiseaseRepository {
  Future<Either> getAllDiseases();
}