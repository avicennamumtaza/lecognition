import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lecognition/domain/user/usecases/get_user_profile.dart';
import 'package:lecognition/presentation/profile/bloc/user_state.dart';
import 'package:lecognition/service_locator.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserLoading());

  void getUserProfile() async {
    final returnedData = await sl<GetUserProfileUseCase>().call();
    returnedData.fold(
      (error) => emit(UserFailureLoad(errorMessage: error.toString())),
      (userData) => emit(UserLoaded(user: userData)),
    );
  }
}