import 'package:lecognition/domain/disease/entities/disease.dart';
import 'package:lecognition/domain/user/entities/user.dart';

class BookmarkEntity {
  int? id;
  UserEntity? user;
  DiseaseEntity? disease;
  int? date;
  bool? status;

  BookmarkEntity({
    this.id,
    this.user,
    this.disease,
    this.date,
    this.status,
  });

  BookmarkEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new UserEntity.fromJson(json['user']) : null;
    disease =
        json['disease'] != null ? new DiseaseEntity.fromJson(json['disease']) : null;
    date = json['date'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.disease != null) {
      data['disease'] = this.disease!.toJson();
    }
    data['date'] = this.date;
    data['status'] = this.status;
    return data;
  }
}