import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lecognition/data/diagnozer/models/get_diagnoze_result_params.dart';
import 'package:lecognition/domain/diagnozer/usecases/get_diagnoze_result.dart';
import 'package:lecognition/presentation/diagnozer/bloc/diagnosis_state.dart';
import 'package:lecognition/service_locator.dart';

class DiagnozerCubit extends Cubit<DiagnosisState> {
  DiagnozerCubit() : super(DiagnosisLoading());

  void getDiagnosis(GetDiagnosisParams params) async {
    final returnedData = await sl<GetDiagnosisUseCase>().call(
      params: params,
    );
    returnedData.fold(
      (error) => emit(DiagnosisFailureLoad(errorMessage: error.toString())),
      (diagnosis) => emit(DiagnosisLoaded(diagnosis: diagnosis)),
    );
  }
}
