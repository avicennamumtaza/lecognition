import 'package:dartz/dartz.dart';
import 'package:lecognition/core/usecase/usecase.dart';
import 'package:lecognition/domain/disease/repositories/disease.dart';
import 'package:lecognition/service_locator.dart';

class GetAllDiseasesUseCase extends Usecase<Either, dynamic> {
  // SignupUseCase({required this.authRepository});
  // final AuthRepository authRepository;
  
  @override
  Future<Either> call({params}) async {
    return await sl<DiseaseRepository>().getAllDiseases();
  }
}