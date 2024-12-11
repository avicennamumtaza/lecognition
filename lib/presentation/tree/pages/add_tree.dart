import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:lecognition/common/helper/navigation/app_navigator.dart';
import 'package:lecognition/widgets/appbar.dart';
import 'package:lecognition/widgets/form.dart';
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
    return Scaffold(
      appBar: AppBarWidget(title: 'Tambah Tanaman'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildFormFields(),
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

  Widget _buildFormFields() {
    return FormBuilder(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: 20),
          FormBoilerplate.buildTextField(
            'desc',
            'Informasi Tentang Tanaman',
            'Pohon mangga madu depan rumah dedi', // Updated hintText
            Icons.title,
            _descController,
            TextInputType.text,
            [
              FormBuilderValidators.required(errorText: 'Tidak boleh kosong'),
              // FormBuilderValidators.max(32, errorText: 'Maksimal 32 karakter'),
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
          AppNavigator.push(
            context,
            CameraScreen(
              nameTree: _descController.text,
              currentLocation: currentLocation!,
            ),
          );
          _isSubmitting = false;
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      child: const Text(
        'Ambil Foto Tanaman',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
