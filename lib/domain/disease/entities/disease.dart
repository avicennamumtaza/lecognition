import 'package:lecognition/domain/disease/entities/disease_detail.dart';

class DiseaseEntity {
  int? id;
  String? name;
  String? desc;
  DiseaseDetail? detail;  // Add this field to hold extra details

  DiseaseEntity({this.id, this.name, this.desc});

  DiseaseEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['desc'] = this.desc;
    return data;
  }
}