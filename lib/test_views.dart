import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
import 'package:lecognition/core/constant/api_urls.dart';
import 'package:lecognition/core/network/dio_client.dart';
import 'package:lecognition/data/auth/models/signin_req_params.dart';
import 'package:lecognition/data/auth/models/signup_req_params.dart';
import 'package:lecognition/service_locator.dart';

abstract class AuthService {
  Future<Either> signup(SignupReqParams params);
  Future<Either> signin(SigninReqParams params);
}

class AuthApiServiceImpl extends AuthService {
  @override
  Future<Either> signup(SignupReqParams params) async {
    try {
      var response = await sl<DioClient>().post(
        ApiUrls.register,
        data: params.toMap(),
      );
      return Right(response.data);
    } on DioException catch (error) {
      // debugPrint(error as String?);
      // debugPrint(error.response!.data);
      return Left(error.response!.data["message"]);
    }
  }

  @override
  Future<Either> signin(SigninReqParams params) async {
    try {
      print(ApiUrls.login);
      var response = await sl<DioClient>().post(
        ApiUrls.login,
        data: params.toMap(),
      );
      return Right(response.data);
    } on DioException catch (error) {
      return Left(error.response!.data["message"]);
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