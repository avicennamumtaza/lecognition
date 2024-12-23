import 'package:get_it/get_it.dart';
import 'package:lecognition/core/network/dio_client.dart';
import 'package:lecognition/data/auth/repositories/auth.dart';
import 'package:lecognition/data/auth/sources/auth_api_service.dart';
import 'package:lecognition/data/bookmark/repositories/bookmark.dart';
import 'package:lecognition/data/bookmark/sources/bookmark_api_service.dart';
import 'package:lecognition/data/diagnozer/repositories/diagnozer.dart';
import 'package:lecognition/data/diagnozer/sources/diagnozer_api_service.dart';
import 'package:lecognition/data/disease/repositories/disease.dart';
import 'package:lecognition/data/disease/sources/disease_api_service.dart';
import 'package:lecognition/data/history/repositories/history.dart';
import 'package:lecognition/data/history/sources/history_api_service.dart';
import 'package:lecognition/data/media/repositories/media.dart';
import 'package:lecognition/data/media/sources/media_api_service.dart';
import 'package:lecognition/data/tree/repositories/tree.dart';
import 'package:lecognition/data/tree/sources/tree_api_service.dart';
import 'package:lecognition/data/user/repositories/user.dart';
import 'package:lecognition/data/user/sources/user_api_service.dart';
import 'package:lecognition/domain/auth/repositories/auth.dart';
import 'package:lecognition/domain/auth/usecases/is_signed_in.dart';
import 'package:lecognition/domain/auth/usecases/signin.dart';
import 'package:lecognition/domain/auth/usecases/signup.dart';
import 'package:lecognition/domain/bookmark/repositories/bookmark.dart';
import 'package:lecognition/domain/bookmark/usecases/bookmark_disease.dart';
import 'package:lecognition/domain/bookmark/usecases/get_bookmarked_diseases.dart';
import 'package:lecognition/domain/bookmark/usecases/unbookmark_disease.dart';
import 'package:lecognition/domain/diagnozer/repositories/diagnozer.dart';
import 'package:lecognition/domain/diagnozer/usecases/get_diagnoze_result.dart';
import 'package:lecognition/domain/disease/repositories/disease.dart';
import 'package:lecognition/domain/disease/usecases/get_all_diseases.dart';
import 'package:lecognition/domain/history/repositories/history.dart';
import 'package:lecognition/domain/history/usecases/get_user_histories.dart';
import 'package:lecognition/domain/media/repositories/media.dart';
import 'package:lecognition/domain/media/usecases/get_image.dart';
import 'package:lecognition/domain/tree/repositories/tree.dart';
import 'package:lecognition/domain/tree/usecases/add_tree.dart';
import 'package:lecognition/domain/tree/usecases/delete_tree.dart';
import 'package:lecognition/domain/tree/usecases/get_tree.dart';
import 'package:lecognition/domain/tree/usecases/get_tree_scans.dart';
import 'package:lecognition/domain/tree/usecases/get_trees.dart';
import 'package:lecognition/domain/tree/usecases/update_tree.dart';
import 'package:lecognition/domain/user/repositories/user.dart';
import 'package:lecognition/domain/user/usecases/get_user_profile.dart';
import 'package:lecognition/domain/user/usecases/update_user_profile.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerSingleton<DioClient>(DioClient());

  // Services
  sl.registerSingleton<AuthService>(AuthApiServiceImpl());
  sl.registerSingleton<DiseaseApiService>(DiseaseApiServiceImpl());
  sl.registerSingleton<BookmarkApiService>(BookmarkApiServiceImpl());
  sl.registerSingleton<UserApiService>(UserApiServiceImpl());
  sl.registerSingleton<DiagnozerApiService>(DiagnozerApiServiceImpl());
  sl.registerSingleton<TreeApiService>(TreeApiServiceImpl());
  sl.registerSingleton<HistoryApiService>(HistoryApiServiceImpl());
  sl.registerSingleton<MediaApiService>(MediaApiServiceImpl());

  // Repositories
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  sl.registerSingleton<DiseaseRepository>(DiseaseRepositoryImpl());
  sl.registerSingleton<BookmarkRepository>(BookmarkRepositoryImpl());
  sl.registerSingleton<UserRepository>(UserRepositoryImpl());
  sl.registerSingleton<DiagnozerRepository>(DiagnozerRepositoryImpl());
  sl.registerSingleton<TreeRepository>(TreeRepositoryImpl());
  sl.registerSingleton<HistoryRepository>(HistoryRepositoryImpl());
  sl.registerSingleton<MediaRepository>(MediaRepositoryImpl());

  // Usecases
  sl.registerSingleton<SignupUseCase>(SignupUseCase());
  sl.registerSingleton<SigninUseCase>(SigninUseCase());
  sl.registerSingleton<IsSignedInUseCase>(IsSignedInUseCase());
  sl.registerSingleton<GetAllDiseasesUseCase>(GetAllDiseasesUseCase());
  sl.registerSingleton<GetBookmarkedDiseasesUseCase>(GetBookmarkedDiseasesUseCase());
  sl.registerSingleton<GetUserProfileUseCase>(GetUserProfileUseCase());
  sl.registerSingleton<UpdateUserProfileUseCase>(UpdateUserProfileUseCase());
  sl.registerSingleton<BookmarkDiseaseUseCase>(BookmarkDiseaseUseCase());
  sl.registerSingleton<UnbookmarkDiseaseUseCase>(UnbookmarkDiseaseUseCase());
  sl.registerSingleton<GetDiagnosisUseCase>(GetDiagnosisUseCase());
  sl.registerSingleton<GetTreesUseCase>(GetTreesUseCase());
  sl.registerSingleton<AddTreeUseCase>(AddTreeUseCase());
  sl.registerSingleton<DeleteTreeUseCase>(DeleteTreeUseCase());
  sl.registerSingleton<GetTreeScansUseCase>(GetTreeScansUseCase());
  sl.registerSingleton<UpdateTreeUseCase>(UpdateTreeUseCase());
  sl.registerSingleton<GetTreeUseCase>(GetTreeUseCase());
  sl.registerSingleton<GetUserHistoriesUseCase>(GetUserHistoriesUseCase());
  sl.registerSingleton<GetImageUseCase>(GetImageUseCase());
}