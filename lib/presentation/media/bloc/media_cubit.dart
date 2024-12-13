import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lecognition/data/media/models/get_image_params.dart';
import 'package:lecognition/domain/media/usecases/get_image.dart';
import 'package:lecognition/presentation/media/bloc/media_state.dart';
import 'package:lecognition/service_locator.dart';

class MediaCubit extends Cubit<MediaState> {
  MediaCubit() : super(MediaLoading());

  void getImage(GetImageParams params) async {
    final returnedImage = await sl<GetImageUseCase>().call(params: params);
    returnedImage.fold(
      (error) => emit(MediaFailureLoad(errorMessage: error.toString())),
      (image) => emit(MediaLoaded(image: image)),
    );
  }
}