import 'package:dartz/dartz.dart';
import 'package:lecognition/data/media/models/get_image_params.dart';

abstract class MediaRepository {
  Future<Either> getImage(GetImageParams params);
}