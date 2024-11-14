import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:lecognition/core/constant/api_urls.dart';
import 'package:lecognition/core/network/dio_client.dart';
import 'package:lecognition/data/auth/models/refresh_token_params.dart';
import 'package:lecognition/data/auth/models/signin_req_params.dart';
import 'package:lecognition/data/auth/models/signup_req_params.dart';
import 'package:lecognition/service_locator.dart';

abstract class AuthService {
  Future<Either<String, dynamic>> signup(SignupReqParams params);
  Future<Either<String, dynamic>> signin(SigninReqParams params);
  Future<Either<String, dynamic>> refreshToken(RefreshTokenParams params);
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
      final statusCode = error.response?.statusCode;
      if (statusCode == 404) {
        return Left("Email/Password is incorrect");
      }
      return Left(error.response?.data["email"] != null
          ? error.response?.data["password"]?.toString() ??
              "An unknown error occurred"
          : "An unknown error occurred");
    }
  }

  @override
  Future<Either<String, dynamic>> refreshToken(
    RefreshTokenParams params,
  ) async {
    final CancelToken cancelToken = CancelToken();
    try {
      print('Data being sent to refresh token endpoint: ${params.toMap()}');

      var response = await sl<DioClient>().post(
        ApiUrls.refreshToken,
        data: params.toMap(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
          validateStatus: (status) {
            return status != null && status < 500; // Menghindari exception 401
          },
        ),
        cancelToken: cancelToken,
      );

      print("Response received with status code: ${response.statusCode}");
      if (response.statusCode == 401) {
        return Left("Invalid refresh token");
      }

      return Right(response.data);
    } on DioException catch (error) {
      // Menangani setiap jenis DioException secara spesifik
      if (error.type == DioExceptionType.unknown ||
          error.type == DioExceptionType.badResponse ||
          error.type == DioExceptionType.sendTimeout ||
          error.type == DioExceptionType.receiveTimeout ||
          error.type == DioExceptionType.badCertificate ||
          error.type == DioExceptionType.cancel ||
          error.type == DioExceptionType.connectionError ||
          error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.values) {
        final statusCode = error.response?.statusCode;
        final errorMessage = error.response?.data["detail"]?.toString() ??
            "An unknown error occurred";

        print(
            "DioExceptionType.response error - Status Code: $statusCode, Detail: $errorMessage");
        if (statusCode == 401) {
          return Left("Invalid refresh token");
        }
        return Left(errorMessage);
      } else if (error.type == DioExceptionType.cancel) {
        print("Request to refresh token was cancelled");
        return Left("Request was cancelled");
      } else {
        print("DioExceptionType.other or unhandled Dio error: $error");
        return Left("An unknown error occurred");
      }
    } catch (e) {
      // Tangkap semua jenis Exception lain yang tidak diharapkan
      print("Unhandled exception in refreshToken: $e");
      return Left("An unexpected error occurred");
      // } finally {
      //   // Pastikan operasi dibatalkan jika tidak diperlukan
      //   if (!cancelToken.isCancelled) {
      //     cancelToken.cancel();
      //   }
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