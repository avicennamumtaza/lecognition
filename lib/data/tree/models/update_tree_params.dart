class UpdateTreeParams {
  UpdateTreeParams({
    this.id,
    this.desc,
    this.longitude,
    this.latitude,
    // this.image,
    // this.user,
  });
  
  final int? id; // Primary key
  final String? desc; // Long description
  final double? longitude; // Longitude coordinate
  final double? latitude; // Latitude coordinate
  // // final String? image; // Image path
  // // final int? user; // Foreign key as integer (user_id)

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'desc': desc,
      'longitude': longitude,
      'latitude': latitude,
      // // 'image': image,
      // // 'user': user,
    };
  }
}
