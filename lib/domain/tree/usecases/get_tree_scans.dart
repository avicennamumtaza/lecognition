import 'package:dartz/dartz.dart';
import 'package:lecognition/core/usecase/usecase.dart';
import 'package:lecognition/data/tree/models/get_tree_scans_params.dart';
import 'package:lecognition/domain/tree/repositories/tree.dart';
import 'package:lecognition/service_locator.dart';

class GetTreeScansUseCase extends Usecase<Either, GetTreeScansParams> {
  @override
  Future<Either> call({GetTreeScansParams? params}) async {
    return await sl<TreeRepository>().getTreeScans(params!);
  }
}