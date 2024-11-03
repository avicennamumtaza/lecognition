import 'package:get_it/get_it.dart';
import 'package:lecognition/core/network/dio_client.dart';
import 'package:lecognition/data/auth/repositories/auth.dart';
import 'package:lecognition/data/auth/sources/auth_api_service.dart';
// import 'package:lecognition/data/movie/repositories/movie.dart';
// import 'package:lecognition/data/movie/sources/movie.dart';
import 'package:lecognition/domain/auth/repositories/auth.dart';
import 'package:lecognition/domain/auth/usecases/is_signed_in.dart';
import 'package:lecognition/domain/auth/usecases/signin.dart';
import 'package:lecognition/domain/auth/usecases/signup.dart';
// import 'package:lecognition/domain/movie/repositories/movie.dart';
// import 'package:lecognition/domain/movie/usecases/get_trending_movies.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerSingleton<DioClient>(DioClient());

  // Services
  sl.registerSingleton<AuthService>(AuthApiServiceImpl());
  // sl.registerSingleton<MovieService>(MovieApiServiceImpl());

  // Repositories
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  // sl.registerSingleton<MovieRepository>(MovieRepositoryImpl());

  // Usecases
  sl.registerSingleton<SignupUseCase>(SignupUseCase());
  sl.registerSingleton<SigninUseCase>(SigninUseCase());
  sl.registerSingleton<IsSignedInUseCase>(IsSignedInUseCase());
  // sl.registerSingleton<GetTrendingMoviesUseCase>(GetTrendingMoviesUseCase());
}