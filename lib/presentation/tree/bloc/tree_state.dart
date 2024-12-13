import 'package:lecognition/domain/diagnozer/entities/diagnosis.dart';
import 'package:lecognition/domain/history/entities/history.dart';
import 'package:lecognition/domain/tree/entities/tree.dart';

abstract class TreeState {}

class TreeLoading extends TreeState {}

class TreesLoaded extends TreeState {
  final List<TreeEntityWithoutForeign> trees;
  TreesLoaded({required this.trees});
}

class TreeScansLoaded extends TreeState {
  final List<HistoryEntity> scans;
  TreeScansLoaded({required this.scans});
}

class TreeLoaded extends TreeState {
  final TreeEntityWithoutForeign tree;
  TreeLoaded({required this.tree});
}

class TreeFailureLoad extends TreeState {
  final String errorMessage;
  TreeFailureLoad({required this.errorMessage});
}

class TreeActionLoading extends TreeState {}

class TreeActionSuccess extends TreeState {
  // final bool isTree;
  final int? idTree;
  TreeActionSuccess({this.idTree});
}

class TreeActionFailure extends TreeState {
  final String errorMessage;
  TreeActionFailure({required this.errorMessage});
}