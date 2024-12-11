import 'package:lecognition/domain/disease/entities/disease.dart';
import 'package:lecognition/domain/user/entities/user.dart';

class TreeEntity {
  int? id; // Primary key
  String? name; // Long nameription
  double? longitude; // Longitude coordinate
  double? latitude; // Latitude coordinate
  String? image; // Image path
  UserEntity? user; // Foreign key reference to UserEntity
  DiseaseEntity? lastDiagnosis; // Foreign key reference to UserEntity

  TreeEntity({
    this.id,
    this.name,
    this.longitude,
    this.latitude,
    this.image,
    this.user,
    this.lastDiagnosis,
  });

  // Constructor for creating an object from JSON
  TreeEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['desc'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    image = json['image'];
    user = json['user'] != null ? UserEntity.fromJson(json['user']) : null;
    lastDiagnosis = json['last_predicted_disease'];
  }

  // Method to convert the object back to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['name'] = this.name;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['image'] = this.image;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class TreeEntityWithoutForeign {
  int? id; // Primary key
  String? name; // Long nameription
  double? longitude; // Longitude coordinate
  double? latitude; // Latitude coordinate
  String? image; // Image path
  int? user; // Foreign key as integer (user_id)
  int? lastDiagnosis; // Foreign key as integer (user_id)

  TreeEntityWithoutForeign({
    this.id,
    this.name,
    this.longitude,
    this.latitude,
    this.image,
    this.user,
    this.lastDiagnosis,
  });

  // Constructor for creating an object from JSON
  TreeEntityWithoutForeign.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['desc'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    image = json['image'];
    user = json['user']; // Storing user_id directly as an integer
    lastDiagnosis = json['last_predicted_disease'];
  }

  // Method to convert the object back to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['name'] = this.name;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['image'] = this.image;
    data['user'] = this.user; // Include user_id in JSON
    data['user'] = this.user; // Include user_id in JSON
    return data;
  }
}
