import 'package:lecognition/domain/tree/entities/tree.dart';

class TreeMapper {
  static TreeEntity toEntity(TreeEntity data) {
    return TreeEntity(
      id: data.id,
      desc: data.desc,
      longitude: data.longitude,
      latitude: data.latitude,
      image: data.image,
      user: data.user,
    );
  }
  
  static TreeEntityWithoutForeign toEntityWithoutForeign(TreeEntityWithoutForeign data) {
    return TreeEntityWithoutForeign(
      id: data.id,
      desc: data.desc,
      longitude: data.longitude,
      latitude: data.latitude,
      image: data.image,
      user: data.user,
    );
  }
}
