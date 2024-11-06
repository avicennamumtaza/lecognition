import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lecognition/domain/disease/usecases/get_all_diseases.dart';
import 'package:lecognition/presentation/home/bloc/disease_state.dart';
import 'package:lecognition/service_locator.dart';

class DiseaseCubit extends Cubit<DiseaseState> {
  DiseaseCubit() : super(DiseasesLoading());

  void getAllDiseases() async {
    final returnedData = await sl<GetAllDiseasesUseCase>().call();
    returnedData.fold(
      (error) => emit(DiseasesFailureLoad(errorMessage: error.toString())),
      (diseases) => emit(DiseasesLoaded(diseases: diseases)),
    );
  }
}
