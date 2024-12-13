import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lecognition/common/helper/mapper/bookmark_mapper.dart';
import 'package:lecognition/data/tree/models/add_tree_params.dart';
import 'package:lecognition/data/tree/models/delete_tree_params.dart';
import 'package:lecognition/data/tree/models/get_tree_scans_params.dart';
import 'package:lecognition/domain/tree/usecases/add_tree.dart';
import 'package:lecognition/domain/tree/usecases/delete_tree.dart';
import 'package:lecognition/domain/tree/usecases/get_tree.dart';
import 'package:lecognition/domain/tree/usecases/get_tree_scans.dart';
import 'package:lecognition/domain/tree/usecases/get_trees.dart';
import 'package:lecognition/presentation/tree/bloc/tree_state.dart';
import 'package:lecognition/service_locator.dart';

class TreeCubit extends Cubit<TreeState> {
  TreeCubit() : super(TreeLoading());

  void getAllTrees() async {
    final returnedData = await sl<GetTreesUseCase>().call();
    print(returnedData);
    returnedData.fold(
      (error) => emit(
        TreeFailureLoad(
          errorMessage: error.toString(),
        ),
      ),
      (userTrees) => emit(
        TreesLoaded(
          trees: userTrees,
        ),
      ),
    );
  }

  void getTree(GetTreeScansParams params) async {
    final returnedData = await sl<GetTreeUseCase>().call(params: params);
    print(returnedData);
    returnedData.fold(
      (error) => emit(
        TreeFailureLoad(
          errorMessage: error.toString(),
        ),
      ),
      (treeDetail) => emit(
        TreesLoaded(
          trees: treeDetail,
        ),
      ),
    );
  }

  void getTreeScans(GetTreeScansParams params) async {
    final returnedData = await sl<GetTreeScansUseCase>().call(params: params);
    print(returnedData);
    returnedData.fold(
      (error) => emit(
        TreeFailureLoad(
          errorMessage: error.toString(),
        ),
      ),
      (treeScans) => emit(
        TreeScansLoaded(
          scans: treeScans,
        ),
      ),
    );
  }

  // Tambah tree
  void addTree(AddTreeParams params) async {
    emit(TreeActionLoading());
    final result = await sl<AddTreeUseCase>().call(
      params: params
    );

    result.fold(
      (failure) => emit(
        TreeActionFailure(
          errorMessage: failure.toString(),
        ),
      ),
      (success) {
        final treeData = BookmarkMapper.toEntityWithoutForeign(success);
        emit(
          TreeActionSuccess(
            idTree: treeData.id,
          ),
        );
      },
    );
  }

  // Hapus tree
  void deleteTree(DeleteTreeParams params) async {
    emit(TreeActionLoading());
    final result = await sl<DeleteTreeUseCase>().call(
      params: params,
    );

    result.fold(
      (failure) => emit(
        TreeActionFailure(
          errorMessage: failure.toString(),
        ),
      ),
      (_) => emit(
        TreeActionSuccess(),
      ),
    );
  }
}
