import 'package:lecognition/domain/history/entities/history.dart';

class HistoryMapper {
  static HistoryEntity toEntity(HistoryEntity data) {
    return HistoryEntity(
      id: data.id,
      disease: data.disease,
      datetime: data.datetime,
      tree: data.tree,
      user: data.user,
      accuracy: data.accuracy,
      desc: data.desc,
      img: data.img,
    );
  }
}