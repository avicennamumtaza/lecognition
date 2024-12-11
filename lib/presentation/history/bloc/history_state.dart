import 'package:lecognition/domain/history/entities/history.dart';

abstract class HistoryState {}

class HistoryLoading extends HistoryState {}

class HistoryLoaded extends HistoryState {
  final List<HistoryEntity> userHistories;
  HistoryLoaded({required this.userHistories});
}

class HistoryFailureLoad extends HistoryState {
  final String errorMessage;
  HistoryFailureLoad({required this.errorMessage});
}