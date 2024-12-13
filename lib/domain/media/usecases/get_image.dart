import 'package:dartz/dartz.dart';
import 'package:lecognition/core/usecase/usecase.dart';
import 'package:lecognition/data/media/models/get_image_params.dart';
import 'package:lecognition/domain/media/repositories/media.dart';
import 'package:lecognition/service_locator.dart';

class GetImageUseCase extends Usecase<Either, GetImageParams> {
  @override
  Future<Either> call({GetImageParams? params}) async {
    return await sl<MediaRepository>().getImage(params!);
  }
}