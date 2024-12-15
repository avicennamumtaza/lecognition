import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:lecognition/common/helper/message/display_message.dart';
import 'package:lecognition/widgets/appbar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lecognition/data/tree/models/add_tree_params.dart';
import 'package:lecognition/domain/tree/usecases/add_tree.dart';
import 'package:lecognition/presentation/tree/bloc/camera_cubit.dart';
import 'package:lecognition/presentation/tree/bloc/camera_state.dart';
import 'package:lecognition/service_locator.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({
    super.key,
    required this.nameTree,
    required this.currentLocation,
  });
  final String nameTree;
  final LatLng currentLocation;

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  List<CameraDescription> cameras = [];
  CameraController? cameraController;
  XFile? _selectedImage;
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
        return BlocProvider(
          create: (context) => CameraCubit()..putCameraPhoto(_selectedImage!),
          child: BlocBuilder<CameraCubit, CameraPhotoState>(
            builder: (context, state) {
              return AlertDialog(
                title: Text('Konfirmasi', style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary)),
                content: Image(
                  image: FileImage(File(_selectedImage!.path)),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Batal', style: TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer)),
                  ),
                  TextButton(
                    onPressed: () async {
                      try {
                        final result = await sl<AddTreeUseCase>().call(
                          params: AddTreeParams(
                              desc: widget.nameTree,
                              image: _selectedImage!,
                              latitude: widget.currentLocation.latitude,
                              longitude: widget.currentLocation.longitude
                          ),
                        );
                        result.fold(
                              (failure) {
                            DisplayMessage.errorMessage(
                              context,
                              failure.toString(),
                            );
                          },
                          (success) async {
                            int count = 0;
                            Navigator.popUntil(context, (route) {
                              count++;
                              return count == 4;
                            });
                          },
                        );
                      } catch (error) {
                        DisplayMessage.errorMessage(context, error.toString());
                      }
                    },
                    child: Text('Ya', style: TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer)),
                  ),
                ],
              );
            }
          )
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

  Future _pickImageGallery() async {
    try {
      final returnedImage = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      if (returnedImage == null) {
        throw Exception('No image selected');
      }
      setState(() {
        _selectedImage = returnedImage;
      });
      try {
        final result = await sl<AddTreeUseCase>().call(
          params: AddTreeParams(
              desc: widget.nameTree,
              image: _selectedImage!,
              latitude: widget.currentLocation.latitude,
              longitude: widget.currentLocation.longitude
          ),
        );
        result.fold(
          (failure) {
            DisplayMessage.errorMessage(context, failure.toString());
          },
          (success) async {
            int count = 0;
            Navigator.popUntil(context, (route) {
              count++;
              return count == 4;
            });
          },
        );
      } catch (error) {
        DisplayMessage.errorMessage(context, error.toString());
      }
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
      await cameraController?.setFocusMode(FocusMode.auto);
      final XFile image = await cameraController!.takePicture();
      _isTorchOn = false;
      await cameraController?.setFlashMode(FlashMode.off);

      setState(() {
        _selectedImage = image;
      });

      _confirm();
    } catch (e) {
      _showErrorDialog('Error saat mengambil gambar: $e');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error', style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary)),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK', style: TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'Ambil Foto'),
      body: _buildCameraPreview(),
    );
  }

  Widget _buildCameraPreview() {
    if (cameraController == null || cameraController?.value.isInitialized == false) {
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
                    icon: const Icon(Icons.image, size: 35, color: Colors.white),
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
                      icon: const Icon(Icons.circle, size: 50, color: Colors.white),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _toggleFlashlight();
                    },
                    icon: Icon(_isTorchOn ? Icons.flash_on : Icons.flash_off, size: 35, color: Colors.white),
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
