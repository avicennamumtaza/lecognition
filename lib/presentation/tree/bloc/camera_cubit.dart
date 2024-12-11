import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lecognition/presentation/tree/bloc/camera_state.dart';

class CameraCubit extends Cubit<CameraPhotoState> {
  CameraCubit() : super(CameraPhotoLoading());

  void putCameraPhoto(XFile treePhoto) {
    emit(CameraPhotoLoaded(treePhoto: treePhoto));
  }

  XFile? getCameraPhoto() {
    if (state is CameraPhotoLoaded) {
      return (state as CameraPhotoLoaded).treePhoto;
    }
    return null; // Jika foto belum tersedia
  }

  // Tambah tree
  // void addTree(AddTreeParams params) async {
  //   emit(TreeActionLoading());
  //   final result = await sl<AddTreeUseCase>().call(
  //       params: params
  //   );
  //
  //   result.fold(
  //         (failure) => emit(
  //       TreeActionFailure(
  //         errorMessage: failure.toString(),
  //       ),
  //     ),
  //         (success) {
  //       final treeData = BookmarkMapper.toEntityWithoutForeign(success);
  //       emit(
  //         TreeActionSuccess(
  //           idTree: treeData.id,
  //         ),
  //       );
  //     },
  //   );
  // }
  //
  // // Hapus tree
  // void deleteTree(DeleteTreeParams params) async {
  //   emit(TreeActionLoading());
  //   final result = await sl<DeleteTreeUseCase>().call(
  //     params: params,
  //   );
  //
  //   result.fold(
  //         (failure) => emit(
  //       TreeActionFailure(
  //         errorMessage: failure.toString(),
  //       ),
  //     ),
  //         (_) => emit(
  //       TreeActionSuccess(),
  //     ),
  //   );
  // }
}
