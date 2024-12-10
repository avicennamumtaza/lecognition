import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lecognition/data/auth/models/refresh_token_params.dart';
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
        final storage = FlutterSecureStorage();
        await storage.write(
          key: '1',
          value: data['access'],
        );
        await storage.write(
          key: '2',
          value: data['refresh'],
        );
        Map<String, dynamic> valueStorage = await storage.readAll();
        print(valueStorage);
        await storage.deleteAll();
        final SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString('access_token', data['access']);
        sharedPreferences.setString('refresh', data['refresh']);
        return Right(data);
      },
    );
  }

  @override
  Future<bool> isSignedIn(RefreshTokenParams params) async {
    try {
      var data = await sl<AuthService>().refreshToken(params);

      final bool returned = await data.fold(
        (error) {
          print('Refresh token request error: $error');
          return false;
        },
        (data) async {
          final storage = FlutterSecureStorage();
          await storage.write(
            key: '1',
            value: data['access'],
          );
          await storage.write(
            key: '2',
            value: data['refresh'],
          );
          Map<String, dynamic> valueStorage = await storage.readAll();
          print(valueStorage);
          await storage.deleteAll();
          final SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          sharedPreferences.setString('access_token', data['access']);
          print(data['access']);
          sharedPreferences.setString('refresh', data['refresh']);
          return true;
        },
      );

      return returned;
    } catch (e) {
      // Log the unexpected error and return false
      print("Unexpected error in isSignedIn: $e");
      return false;
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
