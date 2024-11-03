import 'package:dartz/dartz.dart';
import 'package:lecognition/core/usecase/usecase.dart';
import 'package:lecognition/data/auth/models/signup_req_params.dart';
import 'package:lecognition/domain/diagnozer/repositories/diagnozer.dart';
// import 'package:lecognition/domain/disease/repositories/disease.dart';
// import 'package:lecognition/domain/auth/repositories/auth.dart';
// import 'package:lecognition/domain/user/repositories/user.dart';
import 'package:lecognition/service_locator.dart';

class GetDiagnozeResultUseCase extends Usecase<Either, SignupReqParams> {
  // SignupUseCase({required this.authRepository});
  // final AuthRepository authRepository;

  @override
  Future<Either> call({SignupReqParams? params}) async {
    return await sl<DiagnozerRepository>().getDiagnozeResult(params!);
  }
}
