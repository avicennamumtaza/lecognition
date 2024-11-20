import 'package:lecognition/domain/disease/entities/disease.dart';
// import 'package:lecognition/domain/disease/entities/disease_detail.dart';
import 'package:lecognition/domain/user/entities/user.dart';

class BookmarkEntity {
  int? id;
  UserEntity? user;
  DiseaseEntity? disease;
  int? date;
  // DiseaseDetail? detail;  // Add this field to hold extra details

  BookmarkEntity({
    this.id,
    this.user,
    this.disease,
    this.date,
  });

  BookmarkEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new UserEntity.fromJson(json['user']) : null;
    disease =
        json['disease'] != null ? new DiseaseEntity.fromJson(json['disease']) : null;
    date = json['date'];
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
    return data;
  }
}


class BookmarkEntityWithoutForeign {
  int? id;
  int? user;
  int? disease;
  int? date;
  // DiseaseDetail? detail;  // Add this field to hold extra details

  BookmarkEntityWithoutForeign({
    this.id,
    this.user,
    this.disease,
    this.date,
  });

  BookmarkEntityWithoutForeign.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    disease = json['disease'];
    // user = json['user'] != null ? new UserEntity.fromJson(json['user']) : null;
    // disease =
    //     json['disease'] != null ? new DiseaseEntity.fromJson(json['disease']) : null;
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user'] = this.user;
    data['disease'] = this.disease;
    // if (this.user != null) {
    //   data['user'] = this.user!.toJson();
    // }
    // if (this.disease != null) {
    //   data['disease'] = this.disease!.toJson();
    // }
    data['date'] = this.date;
    return data;
  }
}