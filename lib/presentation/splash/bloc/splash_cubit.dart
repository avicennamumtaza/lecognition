import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lecognition/data/auth/models/refresh_token_params.dart';
import 'package:lecognition/domain/auth/usecases/is_signed_in.dart';
import 'package:lecognition/presentation/splash/bloc/splash_state.dart';
import 'package:lecognition/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(DisplaySplash());

  void appStarted() async {
    await Future.delayed(
      const Duration(seconds: 1),
    );
    final prefs = await SharedPreferences.getInstance();
    final refreshToken = prefs.getString('refresh') ?? "unauthorized";
    print(refreshToken);
    var isSignedIn = await sl<IsSignedInUseCase>().call(
      params: RefreshTokenParams(
        refreshToken: refreshToken,
      ),
    );
    if (isSignedIn) {
      emit(Authenticated());
    } else {
      emit(UnAuthenticated());
    }
  }
}