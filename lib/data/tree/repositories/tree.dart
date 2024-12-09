import 'package:dartz/dartz.dart';
import 'package:lecognition/common/helper/mapper/tree_mapper.dart';
import 'package:lecognition/data/tree/models/add_tree_params.dart';
import 'package:lecognition/data/tree/models/delete_tree_params.dart';
import 'package:lecognition/data/tree/sources/tree_api_service.dart';
import 'package:lecognition/domain/tree/entities/tree.dart';
import 'package:lecognition/domain/tree/repositories/tree.dart';
import 'package:lecognition/service_locator.dart';

class TreeRepositoryImpl extends TreeRepository {
  @override
  Future<Either> deleteTree(DeleteTreeParams params) async {
    var data = await sl<TreeApiService>().deleteTree(params);
    return data.fold(
      (error) {
        return Left(error);
      },
      (data) async {
        return Right(data);
      },
    );
  }

  @override
  Future<Either> addTree(AddTreeParams params) async {
    var data =
        await sl<TreeApiService>().addTree(params); // Tunggu hasil dari API
    var resolvedData = await data; // Tunggu resolusi Future
    return resolvedData.fold(
      (error) {
        return Left(error);
      },
      (data) async {
        print("Resulting $data");
        final addedTree = TreeMapper.toEntityWithoutForeign(
          TreeEntityWithoutForeign.fromJson(data),
        );
        print("Resultingggg $addedTree");
        return Right(addedTree);
      },
    );
  }

  @override
  Future<Either> getTrees() async {
    var data = await sl<TreeApiService>().getTrees();
    print(data);
    return data.fold(
      (error) {
        return Left(error);
      },
      (data) async {
        print("data $data");
        final userTrees = List.from(data)
            .map(
              (item) => TreeMapper.toEntityWithoutForeign(
                TreeEntityWithoutForeign.fromJson(item),
              ),
            )
            .toList();
        print("userTrees $userTrees");
        return Right(userTrees);
      },
    );
  }
}
