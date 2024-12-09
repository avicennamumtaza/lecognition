import 'package:lecognition/domain/user/entities/user.dart';

class TreeEntity {
  int? id; // Primary key
  String? desc; // Long description
  double? longitude; // Longitude coordinate
  double? latitude; // Latitude coordinate
  String? image; // Image path
  UserEntity? user; // Foreign key reference to UserEntity

  TreeEntity({
    this.id,
    this.desc,
    this.longitude,
    this.latitude,
    this.image,
    this.user,
  });

  // Constructor for creating an object from JSON
  TreeEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    desc = json['desc'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    image = json['image'];
    user = json['user'] != null ? UserEntity.fromJson(json['user']) : null;
  }

  // Method to convert the object back to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['desc'] = this.desc;
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
  String? desc; // Long description
  double? longitude; // Longitude coordinate
  double? latitude; // Latitude coordinate
  String? image; // Image path
  int? user; // Foreign key as integer (user_id)

  TreeEntityWithoutForeign({
    this.id,
    this.desc,
    this.longitude,
    this.latitude,
    this.image,
    this.user,
  });

  // Constructor for creating an object from JSON
  TreeEntityWithoutForeign.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    desc = json['desc'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    image = json['image'];
    user = json['user']; // Storing user_id directly as an integer
  }

  // Method to convert the object back to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['desc'] = this.desc;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['image'] = this.image;
    data['user'] = this.user; // Include user_id in JSON
    return data;
  }
}
