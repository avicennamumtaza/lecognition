import 'package:lecognition/domain/user/entities/user.dart';

abstract class UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final UserEntity user;
  UserLoaded({required this.user});
}

class UserFailureLoad extends UserState {
  final String errorMessage;
  UserFailureLoad({required this.errorMessage});
}
