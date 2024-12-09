import 'package:dartz/dartz.dart';
import 'package:lecognition/core/usecase/usecase.dart';
import 'package:lecognition/domain/tree/repositories/tree.dart';
import 'package:lecognition/service_locator.dart';

class GetTreesUseCase extends Usecase<Either, dynamic> {
  @override
  Future<Either> call({params}) async {
    return await sl<TreeRepository>().getTrees();
  }
}