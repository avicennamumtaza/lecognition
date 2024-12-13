import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:lecognition/core/constant/api_urls.dart';
import 'package:lecognition/core/network/dio_client.dart';
import 'package:lecognition/data/tree/models/add_tree_params.dart';
import 'package:lecognition/data/tree/models/delete_tree_params.dart';
import 'package:lecognition/data/tree/models/get_tree_scans_params.dart';
import 'package:lecognition/data/tree/models/update_tree_params.dart';
import 'package:lecognition/service_locator.dart';

abstract class TreeApiService {
  Future<Either> getTrees();
  Future<Either> getTreeScans(GetTreeScansParams params);
  Future<Either> getTree(GetTreeScansParams params);
  Future<Either> addTree(AddTreeParams params);
  Future<Either> updateTree(UpdateTreeParams params);
  Future<Either> deleteTree(DeleteTreeParams params);
}

class TreeApiServiceImpl extends TreeApiService {
  @override
  Future<Either> getTrees() async {
    try {
      var response = await sl<DioClient>().get(
        ApiUrls.tree,
        options: Options(
          validateStatus: (status) {
            return status != null && status <= 500;
          },
        ),
      );
      if (response.statusCode! >= 400) {
        print(response.data);
        return Left(response.data.toString());
      }
      return Right(response.data);
    } on DioException catch (error) {
      return Left(error.response!.data["message"]);
    }
  }

  @override
  Future<Either> addTree(AddTreeParams params) async {
    try {
      if (params.image.path.isEmpty) {
        return Left("Image file is empty");
      } else {
        print("PARAMS IMAGE PATH ${params.image.path}");
        FormData formData = FormData.fromMap({
          "image": await MultipartFile.fromFile(params.image.path),
          "desc": params.desc,
          "longitude": params.longitude,
          "latitude": params.latitude,
        });
        print("formData: $formData");
        var response = await sl<DioClient>().post(
          ApiUrls.tree,
          data: formData,
          options: Options(
            validateStatus: (status) {
              // Mengizinkan semua status code agar tidak dianggap sebagai exception
              return status != null && status <= 500;
            },
          ),
        );
        if (response.statusCode! >= 400) {
          print(response.data);
          return Left(response.data.toString());
        }
        print('Response: ${response.data}');
        if (response.statusCode == 201) {
          return Right(response.data);
        } else {
          return Left(
            'Terjadi kesalahan ${response.data} dengan status code ${response.statusCode}',
          );
        }
      }
    } on DioException catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either> deleteTree(DeleteTreeParams params) async {
    try {
      var response = await sl<DioClient>().delete(
        ApiUrls.tree + "/${params.treeId.toString()}",
      );
      print(response);
      return Right(response.toString());
    } on DioException catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either> getTreeScans(GetTreeScansParams params) async {
    try {
      var response = await sl<DioClient>().get(
        ApiUrls.scanByTree + "/${params.treeId}",
        options: Options(
          validateStatus: (status) {
            return status != null && status <= 500;
          },
        ),
      );
      print(response);
      return Right(response.data);
    } on DioException catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either> updateTree(UpdateTreeParams params) async {
    try {
      print(params.toMap());
      var response = await sl<DioClient>().put(
        ApiUrls.tree + "/${params.id}",
        data: params.toMap(),
        options: Options(
          validateStatus: (status) {
            return status != null && status <= 500;
          },
        ),
      );
      print(response);
      return Right(response.toString());
    } on DioException catch (error) {
      return Left(error);
    }
  }
  
  @override
  Future<Either> getTree(GetTreeScansParams params) async {
    try {
      var response = await sl<DioClient>().get(
        ApiUrls.tree + "/${params.treeId}",
        options: Options(
          validateStatus: (status) {
            return status != null && status <= 500;
          },
        ),
      );
      print("RESPONSE GET TREE $response");
      return Right(response.data);
    } on DioException catch (error) {
      return Left(error);
    }
  }
}
