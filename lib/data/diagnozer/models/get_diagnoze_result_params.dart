import 'package:camera/camera.dart';

class GetDiagnosisParams {
  GetDiagnosisParams({
    required this.imageFile,
    required this.treeId,
  });
  final XFile imageFile;
  final int treeId;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "imageFile": imageFile,
      "treeId": treeId,
    };
  }
}