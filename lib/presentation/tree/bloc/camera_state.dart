import 'package:camera/camera.dart';

abstract class CameraPhotoState {}

class CameraPhotoLoading extends CameraPhotoState {}

class CameraPhotoLoaded extends CameraPhotoState {
  final XFile treePhoto;
  CameraPhotoLoaded({required this.treePhoto});
}

class CameraPhotoFailureLoad extends CameraPhotoState {
  final String errorMessage;
  CameraPhotoFailureLoad({required this.errorMessage});
}