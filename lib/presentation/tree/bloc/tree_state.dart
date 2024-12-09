import 'package:lecognition/domain/tree/entities/tree.dart';

abstract class TreeState {}

class TreeLoading extends TreeState {}

class TreeLoaded extends TreeState {
  final List<TreeEntityWithoutForeign> trees;
  TreeLoaded({required this.trees});
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