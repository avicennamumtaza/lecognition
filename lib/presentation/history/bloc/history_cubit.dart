import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lecognition/domain/history/usecases/get_user_histories.dart';
import 'package:lecognition/presentation/history/bloc/history_state.dart';
import 'package:lecognition/service_locator.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit() : super(HistoryLoading());

  void getUserHistories() async {
    final returnedData = await sl<GetUserHistoriesUseCase>().call();
    returnedData.fold(
      (error) => emit(
        HistoryFailureLoad(
          errorMessage: error.toString(),
        ),
      ),
      (data) => emit(
        HistoryLoaded(
          userHistories: data,
        ),
      ),
    );
  }
}
