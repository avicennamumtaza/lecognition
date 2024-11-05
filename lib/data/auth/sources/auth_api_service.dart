import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:lecognition/core/constant/api_urls.dart';
import 'package:lecognition/core/network/dio_client.dart';
import 'package:lecognition/data/auth/models/signin_req_params.dart';
import 'package:lecognition/data/auth/models/signup_req_params.dart';
import 'package:lecognition/service_locator.dart';

abstract class AuthService {
  Future<Either<String, dynamic>> signup(SignupReqParams params);
  Future<Either<String, dynamic>> signin(SigninReqParams params);
}

class AuthApiServiceImpl extends AuthService {
  @override
  Future<Either<String, dynamic>> signup(SignupReqParams params) async {
    try {
      var response = await sl<DioClient>().post(
        ApiUrls.register,
        data: params.toMap(),
      );
      return Right(response.data);
    } on DioException catch (error) {
      print(error.response?.data["email"].toString());
      return Left(error.response?.data["email"] != null
          ? error.response?.data["password"]?.toString() ??
              "An unknown error occurred"
          : "An unknown error occurred");
    }
  }

  @override
  Future<Either<String, dynamic>> signin(SigninReqParams params) async {
    try {
      var response = await sl<DioClient>().post(
        ApiUrls.login,
        data: params.toMap(),
      );
      return Right(response.data);
    } on DioException catch (error) {
      print(error.response?.data["email"].toString());
      return Left(error.response?.data["email"] != null
          ? error.response?.data["password"]?.toString() ??
              "An unknown error occurred"
          : "An unknown error occurred");
    }
  }
}

// class AuthFirebaseServiceImpl extends AuthService {
//   @override
//   Future<Either> signup(SignupReqParams params) {
//     // implementation of firebase auth logic
//     throw UnimplementedError();
//   }
// }