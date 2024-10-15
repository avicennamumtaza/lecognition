import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lecognition/screens/result.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  void initState() {
    super.initState();
    _setupCameraController();
  }

  Future<void> _saveImagePathToPreferences(String imagePath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedImages = prefs.getStringList('diagnosis_images');

    // Jika belum ada daftar gambar, buat list baru
    if (savedImages == null) {
      savedImages = [];
    }

    // Tambahkan path gambar ke dalam daftar
    savedImages.add(imagePath);

    // Simpan kembali daftar gambar
    await prefs.setStringList('diagnosis_images', savedImages);
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
      // Mendapatkan direktori lokal aplikasi
      final directory = await getApplicationDocumentsDirectory();

      // Membuat path baru untuk gambar
      final fileName = imageFile.path.split('/').last;
      final newImagePath = '${directory.path}/$fileName';

      // Menyalin gambar ke direktori lokal
      final newImage = await imageFile.copy(newImagePath);

      return newImage;
    } catch (e) {
      throw Exception('Error saat menyimpan gambar: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildCameraPreview();
  }

  Future _pickImageGallery() async {
    try {
      final returnedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (returnedImage == null) {
        throw Exception('No image selected');
      }
      setState(() {
        _selectedImage = File(returnedImage.path);
      });
      final savedImage = await _saveImageLocally(_selectedImage!);
      await _saveImagePathToPreferences(savedImage.path);
      _navigateToResultScreen(); // Navigate to result screen if image is selected
    } catch (e) {
      _showErrorDialog('Failed to pick image from gallery: ${e.toString()}');
    }
  }

  Future<void> _setupCameraController() async {
    List<CameraDescription> cameraList = await availableCameras();
    if (cameraList.isNotEmpty) {
      setState(() {
        cameras = cameraList;
        cameraController =
            CameraController(cameraList.first, ResolutionPreset.high);
      });
      cameraController?.initialize().then((_) {
        setState(() {});
      });
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
      await cameraController?.setFocusMode(FocusMode.auto); // Fokus otomatis
      final XFile image = await cameraController!.takePicture();
      _isTorchOn = false;
      await cameraController?.setFlashMode(FlashMode.off);

      setState(() {
        _selectedImage = File(image.path);
      });

      final savedImage = await _saveImageLocally(_selectedImage!);
      await _saveImagePathToPreferences(savedImage.path);

      // Navigasi ke layar hasil (ResultScreen)
      _navigateToResultScreen();
    } catch (e) {
      _showErrorDialog('Error saat mengambil gambar: $e');
    }
  }

  void _navigateToResultScreen() {
    if (_selectedImage != null) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ResultScreen(photo: _selectedImage!)));
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

  Widget _buildCameraPreview() {
    if (cameraController == null ||
        cameraController?.value.isInitialized == false) {
      return const Center(
        child: SpinKitSquareCircle(
          color: Colors.green,
          size: 50.0,
        ),
      );
    }
    return SafeArea(
      child: Stack(
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
                      onPressed: _takePicture, // Mengambil gambar langsung
                      icon: const Icon(Icons.camera,
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
