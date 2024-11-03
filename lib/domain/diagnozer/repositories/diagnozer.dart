import 'package:dartz/dartz.dart';

abstract class DiagnozerRepository {
  Future<Either> getDiagnozeResult();
}