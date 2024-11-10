import 'package:dio/dio.dart';
import 'package:lecognition/core/constant/api_urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'interceptors.dart';

class DioClient {
  late final Dio _dio;

  // Future<String> getToken() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final token = prefs.getString('access_token') ?? 'unauthorized';
  //   print(token);
  //   return token;
  // }

  DioClient()
      : _dio = Dio(
          BaseOptions(
            baseUrl: ApiUrls.baseUrl,
            headers: {
              'Content-Type': 'application/json',
              // 'Authorization':
              //     'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzMxMzM4ODY3LCJpYXQiOjE3MzEyNTIwMzEsImp0aSI6IjY1MTk0NWVhOGE3ZDRmZTNhMzFiMTk3NWIxZjMwZTlmIiwidXNlcl9pZCI6MTJ9.iL2RMr0MpvNjc1RUeK0uKzXMYV7yIZ0YjPhFcMIMSAw',
            },
            responseType: ResponseType.json,
            sendTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
          ),
        )..interceptors.addAll(
            [
              AuthorizationInterceptor(),
              LoggerInterceptor(),
            ],
          );

  // GET METHOD
  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException {
      rethrow;
    }
  }

  // // GET FOR AUTHENTICATED USER METHOD
  // Future<Response> userGet(
  //   String url, {
  //   Map<String, dynamic>? queryParameters,
  //   Options? options,
  //   CancelToken? cancelToken,
  //   ProgressCallback? onReceiveProgress,
  // }) async {
  //   try {
  //     final prefs = await SharedPreferences.getInstance();
  //     final token = prefs.getString('access_token');
  //     print('Retrieved token: $token');

  //     if (token == null || token == 'unauthorized') {
  //       throw Exception('Token is null or unauthorized');
  //     }

  //     // _dio.options.headers.clear();

  //     final newOptions = Options(
  //       headers: {
  //         'Authorization':
  //             'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzMxMzM4ODY3LCJpYXQiOjE3MzEyNTIwMzEsImp0aSI6IjY1MTk0NWVhOGE3ZDRmZTNhMzFiMTk3NWIxZjMwZTlmIiwidXNlcl9pZCI6MTJ9.iL2RMr0MpvNjc1RUeK0uKzXMYV7yIZ0YjPhFcMIMSAw',
  //         ...?options?.headers,
  //       },
  //     );

  //     print(newOptions);
  //     print(newOptions.headers);

  //     _dio.options.headers["Authorization"] =
  //         "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzMxMzM4ODY3LCJpYXQiOjE3MzEyNTIwMzEsImp0aSI6IjY1MTk0NWVhOGE3ZDRmZTNhMzFiMTk3NWIxZjMwZTlmIiwidXNlcl9pZCI6MTJ9.iL2RMr0MpvNjc1RUeK0uKzXMYV7yIZ0YjPhFcMIMSAw";

  //     final Response response = await _dio.get(
  //       url,
  //       queryParameters: queryParameters,
  //       options: newOptions,
  //       cancelToken: cancelToken,
  //       onReceiveProgress: onReceiveProgress,
  //     );

  //     print('_dio options headers before request: ${_dio.options.headers}');
  //     print('Final request headers: ${response.requestOptions.headers}');
  //     return response;
  //   } on DioException {
  //     rethrow;
  //   }
  // }

  // POST METHOD
  Future<Response> post(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.post(url,
          data: data,
          options: options,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
          cancelToken: cancelToken);
      return response;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  // // POST METHOD
  // Future<Response> userPost(
  //   String url, {
  //   data,
  //   Map<String, dynamic>? queryParameters,
  //   Options? options,
  //   CancelToken? cancelToken,
  //   ProgressCallback? onSendProgress,
  //   ProgressCallback? onReceiveProgress,
  // }) async {
  //   try {
  //     final prefs = await SharedPreferences.getInstance();
  //     final token = prefs.getString('access_token');
  //     print('Retrieved token: $token');

  //     if (token == null || token == 'unauthorized') {
  //       throw Exception('Token is null or unauthorized');
  //     }

  //     options = (options ?? Options()).copyWith(
  //       headers: {
  //         'Authorization': 'Bearer $token',
  //         ...?options?.headers,
  //       },
  //     );

  //     final Response response = await _dio.post(url,
  //         data: data,
  //         options: options,
  //         onSendProgress: onSendProgress,
  //         onReceiveProgress: onReceiveProgress,
  //         cancelToken: cancelToken);
  //     return response;
  //   } catch (e) {
  //     print(e);
  //     rethrow;
  //   }
  // }

  // PUT METHOD
  Future<Response> put(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // // PUT METHOD FOR AUTHENTICATED USER
  // Future<Response> userPut(
  //   String url, {
  //   dynamic data,
  //   Map<String, dynamic>? queryParameters,
  //   Options? options,
  //   CancelToken? cancelToken,
  //   ProgressCallback? onSendProgress,
  //   ProgressCallback? onReceiveProgress,
  // }) async {
  //   try {
  //     final prefs = await SharedPreferences.getInstance();
  //     final token = prefs.getString('access_token') ?? 'unauthorized';
  //     print(token);

  //     options = (options ?? Options()).copyWith(
  //       headers: {
  //         'Authorization': 'Bearer $token',
  //         ...?options?.headers,
  //       },
  //     );

  //     final Response response = await _dio.put(
  //       url,
  //       data: data,
  //       queryParameters: queryParameters,
  //       options: options,
  //       cancelToken: cancelToken,
  //       onSendProgress: onSendProgress,
  //       onReceiveProgress: onReceiveProgress,
  //     );
  //     return response;
  //   } catch (e) {
  //     print(e);
  //     rethrow;
  //   }
  // }

  // DELETE METHOD
  Future<dynamic> delete(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final Response response = await _dio.delete(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  // // DELETE METHOD FOR AUTHENTICATED USER
  // Future<dynamic> userDelete(
  //   String url, {
  //   dynamic data,
  //   Map<String, dynamic>? queryParameters,
  //   Options? options,
  //   CancelToken? cancelToken,
  // }) async {
  //   try {
  //     final prefs = await SharedPreferences.getInstance();
  //     final token = prefs.getString('access_token') ?? 'unauthorized';
  //     print(token);

  //     options = (options ?? Options()).copyWith(
  //       headers: {
  //         'Authorization': 'Bearer $token',
  //         ...?options?.headers,
  //       },
  //     );

  //     final Response response = await _dio.delete(
  //       url,
  //       data: data,
  //       queryParameters: queryParameters,
  //       options: options,
  //       cancelToken: cancelToken,
  //     );
  //     return response.data;
  //   } catch (e) {
  //     print(e);
  //     rethrow;
  //   }
  // }
}
