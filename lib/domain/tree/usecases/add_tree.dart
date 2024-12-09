import 'package:dartz/dartz.dart';
import 'package:lecognition/core/usecase/usecase.dart';
import 'package:lecognition/data/tree/models/add_tree_params.dart';
import 'package:lecognition/domain/tree/repositories/tree.dart';
import 'package:lecognition/service_locator.dart';

class AddTreeUseCase extends Usecase<Either, AddTreeParams> {
  @override
  Future<Either> call({AddTreeParams? params}) async {
    return await sl<TreeRepository>().addTree(params!);
  }
}