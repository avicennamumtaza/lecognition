import 'dart:convert';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:lecognition/data/media/models/get_image_params.dart';
import 'package:lecognition/data/media/sources/media_api_service.dart';
import 'package:lecognition/domain/media/repositories/media.dart';
import 'package:lecognition/service_locator.dart';

class MediaRepositoryImpl extends MediaRepository {
  @override
  Future<Either> getImage(GetImageParams params) async {
    var data = await sl<MediaApiService>().getImage(params);
    return data.fold(
      (error) {
        return Left(error);
      },
      (data) async {
        // print(
        //   "================================================ DATA GET IMAGE MEDIA REPOSITORY $data",
        // );
        Uint8List uint8List = Uint8List.fromList(utf8.encode(data));
        return Right(uint8List);
      },
    );
  }
}
