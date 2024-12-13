import 'dart:typed_data';

abstract class MediaState {}

class MediaLoading extends MediaState {}

class MediaLoaded extends MediaState {
  final Uint8List image;
  MediaLoaded({required this.image});
}

class MediaFailureLoad extends MediaState {
  final String errorMessage;
  MediaFailureLoad({required this.errorMessage});
}