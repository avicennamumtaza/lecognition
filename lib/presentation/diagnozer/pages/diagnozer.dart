import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lecognition/presentation/diagnozer/pages/result.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:lecognition/data/dummy_diagnosis.dart';
// import 'package:lecognition/data/dummy_disease.dart';
// import 'dart:math';

class DiagnozerScreen extends StatefulWidget {
  const DiagnozerScreen({super.key});

  @override
  State<DiagnozerScreen> createState() => _DiagnozerScreenState();
}

class _DiagnozerScreenState extends State<DiagnozerScreen> {
  List<CameraDescription> cameras = [];
  CameraController? cameraController;
  File? _selectedImage;
  bool _isTorchOn = false;

  @override
  void dispose() {
    if (_isTorchOn) {
      cameraController?.setFlashMode(FlashMode.off);
    }
    if (cameraController != null && cameraController!.value.isInitialized) {
      cameraController?.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _setupCameraController();
  }

  Future<void> _setupCameraController() async {
    List<CameraDescription> cameraList = await availableCameras();
    if (cameraList.isNotEmpty) {
      setState(() {
        cameras = cameraList;
        cameraController = CameraController(
          cameraList.first,
          ResolutionPreset.high,
        );
      });
      cameraController?.initialize().then((_) {
        setState(() {});
      });
    }
  }

  Future<void> _confirm() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi'),
          content: Image(
            image: _selectedImage != null
                ? FileImage(_selectedImage!)
                : AssetImage(
                    'assets/avatars/Avatar_3.png',
                  ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _saveImageLocally(_selectedImage!);
                _saveDiagnosis(_selectedImage!);
                _navigateToResultScreen();
              },
              child: const Text('Ya'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _toggleFlashlight() async {
    try {
      if (_isTorchOn) {
        await cameraController?.setFlashMode(FlashMode.off);
      } else {
        await cameraController?.setFlashMode(FlashMode.torch);
      }
      setState(() {
        _isTorchOn = !_isTorchOn;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<File> _saveImageLocally(File imageFile) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final fileName = imageFile.path.split('/').last;
      final newImagePath = '${directory.path}/$fileName';
      final newImage = await imageFile.copy(newImagePath);

      return newImage;
    } catch (e) {
      throw Exception('Error saat menyimpan gambar: $e');
    }
  }

  Future<void> _saveDiagnosis(File image) async {
    // final randomIndex = Random().nextInt(diagnosises.length);
    // final randomDiagnosis = diagnosises[randomIndex];
    // final diseaseId = randomDiagnosis.diseaseId;
    // final matchingDisease = diseases.firstWhere(
    //   (disease) => disease.id == diseaseId,
    // );

    final plantName = "nama mangga";
    // final diseaseId = "1";

    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedImages = prefs.getStringList('diagnosis_images') ?? [];
    List<String>? savedPlantNames = prefs.getStringList('plant_names') ?? [];
    // List<String>? savedDiseaseId =
    //     prefs.getStringList('disease_id') ?? [];

    savedImages.add(image.path);
    savedPlantNames.add(plantName);
    // savedDiseaseId.add(diseaseId);
    print("savedPlantNames: $savedPlantNames");
    print("savedImages: $savedImages");

    await prefs.setStringList('diagnosis_images', savedImages);
    await prefs.setStringList('plant_names', savedPlantNames);
    // await prefs.setStringList('disease_id', savedDiseaseId);
  }

  Future _pickImageGallery() async {
    try {
      final returnedImage = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      if (returnedImage == null) {
        throw Exception('No image selected');
      }
      setState(() {
        _selectedImage = File(returnedImage.path);
      });
      await _saveImageLocally(_selectedImage!);
      await _saveDiagnosis(_selectedImage!);
      _navigateToResultScreen();
    } catch (e) {
      _showErrorDialog('Failed to pick image from gallery: ${e.toString()}');
    }
  }

  Future<void> _takePicture() async {
    if (cameraController == null || !cameraController!.value.isInitialized) {
      _isTorchOn = false;
      await cameraController?.setFlashMode(FlashMode.off);
      _showErrorDialog('Kamera belum diinisialisasi.');
      return;
    }

    try {
      // Ambil gambar dari kamera dan simpan dalam file sementara
      await cameraController?.setFocusMode(FocusMode.auto);
      final XFile image = await cameraController!.takePicture();
      _isTorchOn = false;
      await cameraController?.setFlashMode(FlashMode.off);

      setState(() {
        _selectedImage = File(image.path);
      });

      // await _saveImageLocally(_selectedImage!);
      // await _saveDiagnosis(savedImage);
      _confirm();
    } catch (e) {
      _showErrorDialog('Error saat mengambil gambar: $e');
    }
  }

  void _navigateToResultScreen() async {
    if (_selectedImage != null) {
      try {
        final prefs = await SharedPreferences.getInstance();
        List<String>? savedPlantNames =
            prefs.getStringList('plant_names') ?? [];

        String diseaseName = savedPlantNames.isNotEmpty
            ? savedPlantNames.last
            : 'Unknown Disease';

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ResultScreen(
              photo: XFile(_selectedImage!.path),
              plantName: diseaseName,
            ),
          ),
        );
      } catch (e) {
        _showErrorDialog("Failed to navigate to result screen: $e");
      }
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildCameraPreview();
  }

  Widget _buildCameraPreview() {
    if (cameraController == null ||
        cameraController?.value.isInitialized == false) {
      return const Center(
        child: SpinKitSquareCircle(
          color: Color.fromARGB(255, 255, 131, 23),
          size: 50.0,
        ),
      );
    }
    return SafeArea(
      child: Stack(
        fit: StackFit.expand,
        children: [
          CameraPreview(cameraController!),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: _pickImageGallery,
                    icon:
                        const Icon(Icons.image, size: 35, color: Colors.white),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border(
                        top: BorderSide(width: 1, color: Colors.white),
                        bottom: BorderSide(width: 1, color: Colors.white),
                        left: BorderSide(width: 1, color: Colors.white),
                        right: BorderSide(width: 1, color: Colors.white),
                      ),
                    ),
                    child: IconButton(
                      onPressed: _takePicture,
                      icon: const Icon(Icons.circle,
                          size: 50, color: Colors.white),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _toggleFlashlight();
                    },
                    icon: Icon(_isTorchOn ? Icons.flash_on : Icons.flash_off,
                        size: 35, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
