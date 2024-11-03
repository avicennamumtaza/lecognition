// // auth_api_service_test.dart
// import 'package:dartz/dartz.dart';
// import 'package:dio/dio.dart';
// import 'package:lecognition/core/constant/api_urls.dart';
// import 'package:lecognition/core/network/dio_client.dart';
// import 'package:lecognition/data/auth/models/signin_req_params.dart';
// import 'package:lecognition/data/auth/models/signup_req_params.dart';
// import 'package:lecognition/data/auth/sources/auth_api_service.dart';
// import 'package:lecognition/service_locator.dart';
// import 'package:mockito/mockito.dart';

// class MockDioClient extends Mock implements DioClient {}

// void main() {
// 	late MockDioClient mockDioClient;
// 	late AuthApiServiceImpl authApiService;

// 	setUp(() {
// 		mockDioClient = MockDioClient();
// 		authApiService = AuthApiServiceImpl();
// 		sl.registerSingleton<DioClient>(mockDioClient);
// 	});

// 	group('AuthApiServiceImpl', () {
// 		final signupParams = SignupReqParams(username: 'test', email: 'test@test.com', password: 'password');
// 		final signinParams = SigninReqParams(email: 'test@test.com', password: 'password');

// 		test('signup success', () async {
// 			when(mockDioClient.post(ApiUrls.register, data: anyNamed('data'))).thenAnswer((_) async => Response(data: {'success': true}, statusCode: 200, requestOptions: RequestOptions(path: '/')));

// 			final result = await authApiService.signup(signupParams);

// 			expect(result.isRight(), true);
// 		});

// 		test('signup failure', () async {
//       when(mockDioClient.post(ApiUrls.register, data: anyNamed('data'))).thenThrow(DioException(response: Response(data: {'message': 'Error'}, statusCode: 400, requestOptions: RequestOptions(path: '/')), requestOptions: RequestOptions(path: '/')));

// 			final result = await authApiService.signup(signupParams);

// 			expect(result.isLeft(), true);
// 		});

// 		test('signin success', () async {
// 			when(mockDioClient.post(ApiUrls.login, data: anyNamed('data'))).thenAnswer((_) async => Response(data: {'success': true}, statusCode: 200, requestOptions: RequestOptions(path: '/')));

// 			final result = await authApiService.signin(signinParams);

// 			expect(result.isRight(), true);
// 		});

// 		test('signin failure', () async {
// 			when(mockDioClient.post(ApiUrls.login, data: anyNamed('data'))).thenThrow(DioException(requestOptions: RequestOptions(path: '/'), response: Response(data: {'message': 'Error'}, statusCode: 400, requestOptions: RequestOptions(path: '/'))));

// 			final result = await authApiService.signin(signinParams);

// 			expect(result.isLeft(), true);
// 		});

//     test('signup network error', () async {
//       when(mockDioClient.post(ApiUrls.register, data: anyNamed('data'))).thenThrow(DioException(requestOptions: RequestOptions(path: '/')));

//       final result = await authApiService.signup(signupParams);

//       expect(result.isLeft(), true);
//     });

//     test('signin network error', () async {
//       when(mockDioClient.post(ApiUrls.login, data: anyNamed('data'))).thenThrow(DioException(requestOptions: RequestOptions(path: '/')));

//       final result = await authApiService.signin(signinParams);

//       expect(result.isLeft(), true);
//     });

//     test('signup invalid data', () async {
//       final invalidSignupParams = SignupReqParams(username: '', email: 'invalid', password: 'short');

//       when(mockDioClient.post(ApiUrls.register, data: anyNamed('data'))).thenThrow(DioException(response: Response(data: {'message': 'Invalid data'}, statusCode: 422, requestOptions: RequestOptions(path: '/')), requestOptions: RequestOptions(path: '/')));

//       final result = await authApiService.signup(invalidSignupParams);

//       expect(result.isLeft(), true);
//     });

//     test('signin invalid data', () async {
//       final invalidSigninParams = SigninReqParams(email: 'invalid', password: 'short');

//       when(mockDioClient.post(ApiUrls.login, data: anyNamed('data'))).thenThrow(DioException(response: Response(data: {'message': 'Invalid data'}, statusCode: 422, requestOptions: RequestOptions(path: '/')), requestOptions: RequestOptions(path: '/')));

//       final result = await authApiService.signin(invalidSigninParams);

//       expect(result.isLeft(), true);
//     });
// 	});
// }