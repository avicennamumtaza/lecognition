import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either> getUserProfile();
  Future<Either> updateUserProfile();
}