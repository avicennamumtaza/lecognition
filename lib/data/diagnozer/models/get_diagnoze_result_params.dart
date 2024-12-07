import 'package:camera/camera.dart';

class GetDiagnosisParams {
  GetDiagnosisParams({
    required this.imageFile,
  });
  final XFile imageFile;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "imageFile": imageFile,
    };
  }
}