import 'package:lecognition/core/usecase/usecase.dart';
import 'package:lecognition/data/auth/models/refresh_token_params.dart';
import 'package:lecognition/domain/auth/repositories/auth.dart';
import 'package:lecognition/service_locator.dart';

class IsSignedInUseCase extends Usecase<bool, RefreshTokenParams> {
  @override
  Future<bool> call({RefreshTokenParams? params}) async {
    return await sl<AuthRepository>().isSignedIn(params!);
  }
}