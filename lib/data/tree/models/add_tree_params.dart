import 'package:camera/camera.dart';

class AddTreeParams {
  AddTreeParams({
    required this.desc,
    required this.longitude,
    required this.latitude,
    required this.image,
  });

  final String desc;
  final double longitude;
  final double latitude;
  final XFile image;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "desc": desc,
      "longitude": longitude,
      "latitude": latitude,
      "image": image,
    };
  }
}
