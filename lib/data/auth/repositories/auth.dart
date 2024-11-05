import 'package:dartz/dartz.dart';
import 'package:lecognition/data/auth/models/signin_req_params.dart';
import 'package:lecognition/data/auth/models/signup_req_params.dart';
import 'package:lecognition/data/auth/sources/auth_api_service.dart';
import 'package:lecognition/domain/auth/repositories/auth.dart';
import 'package:lecognition/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepositoryImpl extends AuthRepository {
  // AuthApiService authApiService;
  // AuthRepositoryImpl({
  //   required this.authApiService,
  // });

  @override
  Future<Either> signup(SignupReqParams params) async {
    var data = await sl<AuthService>().signup(params);
    return data.fold(
      (error) {
        return Left(error);
      },
      (data) async {
        // final SharedPreferences sharedPreferences =
        //     await SharedPreferences.getInstance();
        // sharedPreferences.setString('access_token', data['access'].toString());
        return Right(data);
      },
    );
  }

  @override
  Future<Either> signin(SigninReqParams params) async {
    var data = await sl<AuthService>().signin(params);
    return data.fold(
      (error) {
        return Left(error);
      },
      (data) async {
        final SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString('access_token', data['access']);
        return Right(data);
      },
    );
  }

  @override
  Future<bool> isSignedIn() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('access_token');
    if (token == null) {
      return false;
    } else {
      return true;
    }
  }
}

// Here is implementation examples of abstraction...

// var data1 = AuthRepositoryImpl(
//   authApiService: AuthApiServiceImpl(),
// ).signup(
//   SignupReqParams(email: "email", password: "password"),
// );

// var data2 = AuthRepositoryImpl(
//   authApiService: AuthFirebaseServiceImpl(),
// ).signup(
//   SignupReqParams(email: "email", password: "password"),
// );
