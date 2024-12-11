import 'package:dartz/dartz.dart';

abstract class HistoryRepository {
  Future<Either> getUserHistories();
}