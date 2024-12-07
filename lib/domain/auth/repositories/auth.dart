import 'package:dartz/dartz.dart';
import 'package:lecognition/data/auth/models/refresh_token_params.dart';
import 'package:lecognition/data/auth/models/signin_req_params.dart';
import 'package:lecognition/data/auth/models/signup_req_params.dart';

abstract class AuthRepository {
  Future<Either> signup(SignupReqParams params);
  Future<Either> signin(SigninReqParams params);
  Future<bool> isSignedIn(RefreshTokenParams params);
}