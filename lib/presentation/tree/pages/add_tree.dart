import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:lecognition/common/helper/message/display_message.dart';
import 'package:lecognition/common/widgets/appbar.dart';
import 'package:lecognition/common/widgets/form.dart';
import 'package:lecognition/data/tree/models/add_tree_params.dart';
import 'package:lecognition/domain/tree/usecases/add_tree.dart';
import 'package:lecognition/presentation/tree/bloc/camera_cubit.dart';
import 'package:lecognition/presentation/tree/bloc/camera_state.dart';
import 'package:lecognition/presentation/tree/bloc/tree_cubit.dart';
import 'package:lecognition/service_locator.dart';

import 'camera.dart';

class AddTreeScreen extends StatefulWidget {
  AddTreeScreen({super.key, required this.image});
  // final UserEntity userData;
  final String image;

  @override
  _AddTreeScreenState createState() => _AddTreeScreenState();
}

class _AddTreeScreenState extends State<AddTreeScreen> {
  LatLng? currentLocation;
  final _descController = TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();
  XFile? _image;
  bool _isSubmitting = false;

  Future<LatLng> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Layanan lokasi tidak diaktifkan.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Izin lokasi ditolak.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Izin lokasi ditolak secara permanen.');
    }

    final position = await Geolocator.getCurrentPosition();
    return LatLng(position.latitude, position.longitude);
  }

  @override
  void initState() {
    super.initState();

    // _image = XFile(widget.image);

    getCurrentLocation().then((location) {
      setState(() {
        currentLocation = location;
        print("Current Location: $currentLocation");
      });
    }).catchError((e) {
      print("Error getting location: $e");
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CameraCubit()..getCameraPhoto(),
      child: BlocBuilder<CameraCubit, CameraPhotoState>(builder: (context, state) {
        if (state is CameraPhotoLoaded) {
          print("PPPPPPPPPPPPPPPPPPPRRRRRRRRRRRRRRRRRRRRRIIIIIIIIIIIIIIIIIIIIINNNNNNNNNNNNNNNNTTTTTTTTTTTTTTTTTT");
          print(state.treePhoto);
          return Scaffold(
            appBar: AppBarWidget(title: 'Tambah Tanaman'),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFormFields(state.treePhoto),
                    const SizedBox(height: 20),
                    Center(
                      child: _isSubmitting
                          ? CircularProgressIndicator()
                          : _submitButton(context),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return Scaffold(
          appBar: AppBarWidget(title: 'Tambah Tanaman'),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFormFields(null),
                  const SizedBox(height: 20),
                  Center(
                    child: _isSubmitting
                        ? CircularProgressIndicator()
                        : _submitButton(context),
                  ),
                ],
              ),
            ),
          ),
        );
      }
      )
    );
  }

  Widget _buildFormFields(XFile? foto) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CameraScreen(),),).then(
                      (value) => BlocProvider.of<CameraCubit>(context).getCameraPhoto(),);
              },
              child: (foto != null)
                ? Container(
                height: MediaQuery.of(context).size.width * 0.8,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: FileImage(File(foto.path)), // Konversi XFile ke File
                    fit: BoxFit.cover,
                  ),
                ),
              )

                  : Container(
                    height: MediaQuery.of(context).size.width * 0.8,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200],
                    ),
                    child: Center(
                      child: Icon(
                        Icons.camera_alt,
                        size: 50,
                        color: Colors.grey[400],
                      ),
                    ),
                  ),
              ),
          ),
          SizedBox(height: 20),
          FormBoilerplate.buildTextField(
            'desc',
            'Nama Tanaman',
            'Nama Tanaman', // Updated hintText
            Icons.title,
            _descController,
            TextInputType.text,
            [
              FormBuilderValidators.required(),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _submitButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState?.saveAndValidate() ?? false) {
          setState(() => _isSubmitting = true);

          try {
            final result = await sl<AddTreeUseCase>().call(
              params: AddTreeParams(
                desc: _descController.text,
                // Default Google Office (latitude: 37.421998, longitude: -122.084)
                latitude: currentLocation?.latitude ?? 37.421998,
                longitude: currentLocation?.longitude ?? -122.084, 
              ),
            );
            result.fold(
              (failure) {
                DisplayMessage.errorMessage(context, failure.toString());
              },
              (success) {
                // AppNavigator.pushReplacement(context, const ProfileScreen());
                Navigator.pop(context);
                // DisplayMessage.errorMessage(context, success.toString());
              },
            );
          } catch (error) {
            DisplayMessage.errorMessage(context, error.toString());
          } finally {
            setState(() => _isSubmitting = false);
          }
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      child: const Text(
        'Simpan',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
