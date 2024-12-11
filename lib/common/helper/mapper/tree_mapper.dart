import 'package:lecognition/domain/tree/entities/tree.dart';

class TreeMapper {
  static TreeEntity toEntity(TreeEntity data) {
    return TreeEntity(
      id: data.id,
      name: data.name,
      longitude: data.longitude,
      latitude: data.latitude,
      image: data.image,
      user: data.user,
      lastDiagnosis: data.lastDiagnosis,
    );
  }
  
  static TreeEntityWithoutForeign toEntityWithoutForeign(TreeEntityWithoutForeign data) {
    return TreeEntityWithoutForeign(
      id: data.id,
      name: data.name,
      longitude: data.longitude,
      latitude: data.latitude,
      image: data.image,
      user: data.user,
      lastDiagnosis: data.lastDiagnosis,
    );
  }
}
