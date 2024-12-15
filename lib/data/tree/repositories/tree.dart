import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:lecognition/common/helper/mapper/history_mapper.dart';
import 'package:lecognition/common/helper/mapper/tree_mapper.dart';
import 'package:lecognition/data/tree/models/add_tree_params.dart';
import 'package:lecognition/data/tree/models/delete_tree_params.dart';
import 'package:lecognition/data/tree/models/get_tree_scans_params.dart';
import 'package:lecognition/data/tree/models/update_tree_params.dart';
import 'package:lecognition/data/tree/sources/tree_api_service.dart';
import 'package:lecognition/domain/history/entities/history.dart';
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
        // print("================================");
        // userTrees.map((e) {
        //   if (e.lastDiagnosis != null) {
        //     print(
        //       "LAST PREDICTED DISEASE NAME ${e.lastDiagnosis.toString()}",
        //     );
        //   } else {
        //     print(
        //       "No last diagnosis found for tree with ID ${e.id}",
        //     );
        //   }
        // }).toList();
        // print("userTrees $userTrees");
        return Right(userTrees);
      },
    );
  }

  @override
  Future<Either> getTreeScans(GetTreeScansParams params) async {
    var response = await sl<TreeApiService>().getTreeScans(params);

    return response.fold(
      (error) {
        return Left(error);
      },
      (data) async {
        try {
          // Validasi apakah data adalah String dan mencoba decode JSON
          if (data is String) {
            print("Raw API Response: $data");

            // Pastikan respons JSON valid
            data = jsonDecode(data);
          }

          // Validasi bahwa data adalah List
          if (data is! List) {
            throw FormatException(
                "Unexpected data format: ${data.runtimeType}");
          }

          // Proses data menjadi entitas
          final treeScans = data
              .map(
                (item) => HistoryMapper.toEntity(
                  HistoryEntity.fromJson(item),
                ),
              )
              .toList();

          print("Processed Tree Scans: $treeScans");
          return Right(treeScans);
        } catch (e) {
          print("Error parsing response: $e");
          return Left("Failed to parse API response: $e");
        }
      },
    );
  }

  @override
  Future<Either> updateTree(UpdateTreeParams params) async {
    var data = await sl<TreeApiService>().updateTree(params);
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
  Future<Either> getTree(GetTreeScansParams params) async {
    var data = await sl<TreeApiService>().getTree(params);
    return data.fold(
      (error) {
        return Left(error);
      },
      (data) async {
        print(data is List);
        print("Data $data");
        final returnedData = List.from(data)
            .map(
              (item) => TreeMapper.toEntityWithoutForeign(
                TreeEntityWithoutForeign.fromJson(item),
              ),
            )
            .toList();
        // final returnedData = TreeMapper.toEntityWithoutForeign(
        //   TreeEntityWithoutForeign.fromJson(data),
        // );
        print("Returned data $returnedData");
        return Right(returnedData);
      },
    );
  }
}
