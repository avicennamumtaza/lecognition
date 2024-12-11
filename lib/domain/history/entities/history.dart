import 'package:lecognition/domain/disease/entities/disease.dart';

class HistoryEntity {
  int? id;
  DiseaseEntity? disease;
  Tree? tree;
  int? datetime;
  String? img;
  String? accuracy;
  String? desc;
  int? user;

  HistoryEntity(
      {this.id,
      this.disease,
      this.tree,
      this.datetime,
      this.img,
      this.accuracy,
      this.desc,
      this.user});

  HistoryEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    disease =
        json['disease'] != null ? new DiseaseEntity.fromJson(json['disease']) : null;
    tree = json['tree'] != null ? new Tree.fromJson(json['tree']) : null;
    datetime = json['datetime'];
    img = json['img'];
    accuracy = json['accuracy'];
    desc = json['desc'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.disease != null) {
      data['disease'] = this.disease!.toJson();
    }
    if (this.tree != null) {
      data['tree'] = this.tree!.toJson();
    }
    data['datetime'] = this.datetime;
    data['img'] = this.img;
    data['accuracy'] = this.accuracy;
    data['desc'] = this.desc;
    data['user'] = this.user;
    return data;
  }
}

class Disease {
  int? id;
  String? name;
  String? desc;

  Disease({this.id, this.name, this.desc});

  Disease.fromJson(Map<String, dynamic> json) {
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

class Tree {
  int? id;
  String? desc;
  double? longitude;
  double? latitude;
  String? image;
  int? user;
  int? lastPredictedDisease;

  Tree(
      {this.id,
      this.desc,
      this.longitude,
      this.latitude,
      this.image,
      this.user,
      this.lastPredictedDisease});

  Tree.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    desc = json['desc'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    image = json['image'];
    user = json['user'];
    lastPredictedDisease = json['last_predicted_disease'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['desc'] = this.desc;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['image'] = this.image;
    data['user'] = this.user;
    data['last_predicted_disease'] = this.lastPredictedDisease;
    return data;
  }
}
