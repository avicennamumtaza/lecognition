import 'package:dartz/dartz.dart';
import 'package:lecognition/core/usecase/usecase.dart';
import 'package:lecognition/data/tree/models/delete_tree_params.dart';
import 'package:lecognition/domain/tree/repositories/tree.dart';
import 'package:lecognition/service_locator.dart';

class DeleteTreeUseCase extends Usecase<Either, DeleteTreeParams> {
  @override
  Future<Either> call({DeleteTreeParams? params}) async {
    return await sl<TreeRepository>().deleteTree(params!);
  }
}