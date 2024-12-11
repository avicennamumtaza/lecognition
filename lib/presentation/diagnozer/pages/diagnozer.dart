import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lecognition/domain/tree/entities/tree.dart';
import 'package:lecognition/presentation/diagnozer/pages/result.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lecognition/presentation/tree/bloc/tree_cubit.dart';
import 'package:lecognition/presentation/tree/bloc/tree_state.dart';

import '../../tree/pages/add_tree.dart';

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
  String? _selectedPlantName;
  int? _selectedPlantId;

  List<String> treesName = [];
  List<int> treesId = [];

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

  Future<void> _confirm(List<TreeEntityWithoutForeign> trees) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        print(trees);
        return AlertDialog(
          title: const Text('Konfirmasi'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image(
                height: MediaQuery.of(context).size.height * 0.5,
                image: FileImage(
                  _selectedImage!,
                ),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: "Pilih Tanaman",
                    border: OutlineInputBorder(),
                    fillColor: Colors.white,
                  ),
                  value: _selectedPlantName,
                  items: [
                    ...trees.map((tree) {
                      final treeName = tree.name;
                      return DropdownMenuItem<String>(
                        value: treeName,
                        child: Text(treeName!),
                      );
                    }).toList(),
                    DropdownMenuItem<String>(
                      value: 'add_plant',
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.add, color: Colors.blue),
                          SizedBox(width: 8),
                          Text('Tambah Tanaman', style: TextStyle(color: Colors.blue)),
                        ],
                      ),
                    ),
                  ],
                  onChanged: (String? value) {
                    if (value == 'add_plant') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddTreeScreen(image: '')
                        ),
                      ).then((_) async {
                        BlocProvider.of<TreeCubit>(context).getAllTrees();
                      });
                    } else {
                      setState(() {
                        _selectedPlantName = value;
                        int index = trees.indexWhere((tree) => tree.name == value);
                        _selectedPlantId = trees[index].id;
                      });
                    }
                  }
              ),
            ],
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
                if (_selectedPlantId == null) {
                  _showErrorDialog("Silakan pilih tanaman terlebih dahulu.");
                  return;
                }
                Navigator.of(context).pop();
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

  Future _pickImageGallery(List<TreeEntityWithoutForeign> trees) async {
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
      _confirm(trees);
    } catch (e) {
      _showErrorDialog('Failed to pick image from gallery: ${e.toString()}');
    }
  }

  Future<void> _takePicture(List<TreeEntityWithoutForeign> trees) async {
    if (cameraController == null || !cameraController!.value.isInitialized) {
      _isTorchOn = false;
      await cameraController?.setFlashMode(FlashMode.off);
      _showErrorDialog('Kamera belum diinisialisasi.');
      return;
    }

    try {
      await cameraController?.setFocusMode(FocusMode.auto);
      final XFile image = await cameraController!.takePicture();
      _isTorchOn = false;
      await cameraController?.setFlashMode(FlashMode.off);

      setState(() {
        _selectedImage = File(image.path);
      });

      _confirm(trees);
    } catch (e) {
      _showErrorDialog('Error saat mengambil gambar: $e');
    }
  }

  void _navigateToResultScreen() async {
    if (_selectedImage != null) {
      try {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ResultScreen(
              photo: XFile(_selectedImage!.path),
              treeId: _selectedPlantId!,
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
    return BlocProvider<TreeCubit>(
      create: (context) => TreeCubit()..getAllTrees(),
      child: BlocBuilder<TreeCubit, TreeState>(
        builder: (context, state) {
          if (state is TreesLoaded) {
            return _buildCameraPreview(state.trees);
          } else if (state is TreeLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const Center(
              child: Text('Gagal memuat data tanaman'),
            );
          }
        },
      ),
    );
  }

  Widget _buildCameraPreview(List<TreeEntityWithoutForeign> trees) {
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
                    onPressed: () => _pickImageGallery(trees),
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
                      onPressed: () => _takePicture(trees),
                      icon: const Icon(Icons.circle,
                          size: 50, color: Colors.white),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _toggleFlashlight();
                    },
                    icon: Icon(
                      _isTorchOn ? Icons.flash_on : Icons.flash_off,
                      size: 35,
                      color: Colors.white,
                    ),
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
