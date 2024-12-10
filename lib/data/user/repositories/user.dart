import 'package:dartz/dartz.dart';
import 'package:lecognition/common/helper/mapper/user_mapper.dart';
import 'package:lecognition/data/user/models/update_user_profile_params.dart';
import 'package:lecognition/data/user/sources/user_api_service.dart';
import 'package:lecognition/domain/user/entities/user.dart';
import 'package:lecognition/domain/user/repositories/user.dart';
import 'package:lecognition/service_locator.dart';

class UserRepositoryImpl extends UserRepository {
  @override
  Future<Either> getUserProfile() async {
    var data = await sl<UserApiService>().getUserProfile();
    return data.fold(
      (error) {
        return Left(error);
      },
      (data) async {
        print(data);
        final Map<String, dynamic> userData = data;
        final user = UserMapper.toEntity(
          UserEntity.fromJson(userData),
        );
        print(user);
        return Right(user);
      },
    );
  }

  @override
  Future<Either> updateUserProfile(UpdateUserProfileParams params) async {
    var data = await sl<UserApiService>().updateUserProfile(params);
    return data.fold(
      (error) {
        return Left(error);
      },
      (userData) async {
        print(userData);
        return Right(userData);
      },
    );
  }
}
