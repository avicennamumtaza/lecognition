import 'package:dartz/dartz.dart';
import 'package:lecognition/data/tree/models/add_tree_params.dart';
import 'package:lecognition/data/tree/models/delete_tree_params.dart';
import 'package:lecognition/data/tree/models/get_tree_scans_params.dart';
import 'package:lecognition/data/tree/models/update_tree_params.dart';

abstract class TreeRepository {
  Future<Either> getTrees();
  Future<Either> getTree(GetTreeScansParams params);
  Future<Either> getTreeScans(GetTreeScansParams params);
  Future<Either> addTree(AddTreeParams params);
  Future<Either> updateTree(UpdateTreeParams params);
  Future<Either> deleteTree(DeleteTreeParams params);
}