import 'package:lecognition/domain/disease/entities/disease.dart';

class DiseaseMapper {
  static DiseaseEntity toEntity(DiseaseEntity data) {
    return DiseaseEntity(
      id: data.id,
      name: data.name,
      desc: data.desc,
    );
  }
}
