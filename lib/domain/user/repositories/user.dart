import 'package:dartz/dartz.dart';
import 'package:lecognition/data/user/models/update_user_profile_params.dart';

abstract class UserRepository {
  Future<Either> getUserProfile();
  Future<Either> updateUserProfile(UpdateUserProfileParams params);
}