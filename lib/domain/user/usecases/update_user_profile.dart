import 'package:dartz/dartz.dart';
import 'package:lecognition/core/usecase/usecase.dart';
import 'package:lecognition/data/user/models/update_user_profile_params.dart';
import 'package:lecognition/domain/user/repositories/user.dart';
import 'package:lecognition/service_locator.dart';

class UpdateUserProfileUseCase extends Usecase<Either, UpdateUserProfileParams> {

  @override
  Future<Either> call({UpdateUserProfileParams? params}) async {
    return await sl<UserRepository>().updateUserProfile(params!);
  }
}