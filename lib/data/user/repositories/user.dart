import 'package:dartz/dartz.dart';
import 'package:lecognition/common/helper/mapper/user_mapper.dart';
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
        // final SharedPreferences sharedPreferences =
        //     await SharedPreferences.getInstance();
        // sharedPreferences.setString('access_token', data['access']);
        return Right(user);
      },
    );
  }

  @override
  Future<Either> updateUserProfile() {
    // TODO: implement updateUserProfile
    throw UnimplementedError();
  }
}
