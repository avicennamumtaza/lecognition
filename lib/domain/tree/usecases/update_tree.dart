import 'package:dartz/dartz.dart';
import 'package:lecognition/core/usecase/usecase.dart';
import 'package:lecognition/data/tree/models/update_tree_params.dart';
import 'package:lecognition/domain/tree/repositories/tree.dart';
import 'package:lecognition/service_locator.dart';

class UpdateTreeUseCase extends Usecase<Either, UpdateTreeParams> {
  @override
  Future<Either> call({UpdateTreeParams? params}) async {
    return await sl<TreeRepository>().updateTree(params!);
  }
}