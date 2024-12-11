import 'package:dartz/dartz.dart';
import 'package:lecognition/core/usecase/usecase.dart';
import 'package:lecognition/domain/history/repositories/history.dart';
import 'package:lecognition/service_locator.dart';

class GetUserHistoriesUseCase extends Usecase<Either, dynamic> {
  // SignupUseCase({required this.authRepository});
  // final AuthRepository authRepository;
  
  @override
  Future<Either> call({params}) async {
    return await sl<HistoryRepository>().getUserHistories();
  }
}