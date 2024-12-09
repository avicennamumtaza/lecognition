import 'package:dartz/dartz.dart';
import 'package:lecognition/data/tree/models/add_tree_params.dart';
import 'package:lecognition/data/tree/models/delete_tree_params.dart';

abstract class TreeRepository {
  Future<Either> getTrees();
  Future<Either> addTree(AddTreeParams params);
  Future<Either> deleteTree(DeleteTreeParams params);
}