import 'package:lecognition/core/usecase/usecase.dart';
import 'package:lecognition/domain/auth/repositories/auth.dart';
import 'package:lecognition/service_locator.dart';

class IsSignedInUseCase extends Usecase<bool, dynamic> {
  @override
  Future<bool> call({params}) async {
    return await sl<AuthRepository>().isSignedIn();
  }
}