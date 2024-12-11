import 'dart:convert';

import 'package:lecognition/domain/disease/entities/disease.dart';
import 'package:lecognition/domain/tree/entities/tree.dart';

class DiagnosisEntity {
  int? id;
  int? datetime;
  String? img;
  double? accuracy;
  String? desc;
  int? user;
  int? disease;

  DiagnosisEntity({
    this.id,
    this.datetime,
    this.img,
    this.accuracy,
    this.desc,
    this.user,
    this.disease,
  });

  DiagnosisEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    datetime = json['datetime'];
    img = json['img'];
    accuracy = json['accuracy'];
    desc = json['desc'];
    user = json['user'];
    disease = json['disease'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['datetime'] = this.datetime;
    data['img'] = this.img;
    data['accuracy'] = this.accuracy;
    data['desc'] = this.desc;
    data['user'] = this.user;
    data['disease'] = DiseaseEntity.fromJson(
      jsonDecode(
        this.disease.toString(),
      ),
    ).toJson();
    data['tree']  = TreeEntity.fromJson(
      jsonDecode(
        this.disease.toString(),
      ),
    ).toJson();
    return data;
  }
}
