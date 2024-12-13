import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:lecognition/common/helper/message/display_message.dart';
import 'package:lecognition/widgets/appbar.dart';
import 'package:lecognition/widgets/form.dart';
import 'package:lecognition/data/tree/models/update_tree_params.dart';
import 'package:lecognition/domain/tree/entities/tree.dart';
import 'package:lecognition/domain/tree/usecases/update_tree.dart';
import 'package:lecognition/service_locator.dart';

class EditTreeScreen extends StatefulWidget {
  EditTreeScreen({super.key, required this.tree});
  // final UserEntity userData;
  final TreeEntityWithoutForeign tree;

  @override
  _EditTreeScreenState createState() => _EditTreeScreenState();
}

class _EditTreeScreenState extends State<EditTreeScreen> {
  LatLng? currentLocation;
  var _descController = TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();
  // XFile? _image;
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
    _descController = TextEditingController(text: widget.tree.name);

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
    // _descController = TextEditingController(text: widget.tree.name);
    return Scaffold(
      appBar: AppBarWidget(title: 'Tambah Tanaman'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildFormFields(widget.tree),
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

  Widget _buildFormFields(TreeEntityWithoutForeign? tree) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: 20),
          FormBoilerplate.buildTextField(
            'desc',
            'Informasi Tentang Tanaman',
            widget.tree.name!, // Updated hintText
            Icons.title,
            _descController,
            TextInputType.text,
            [
              FormBuilderValidators.required(errorText: "Tidak boleh kosong"),
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
            print("Edited desc: ${_descController.text}");
            final result = await sl<UpdateTreeUseCase>().call(
              params: UpdateTreeParams(
                desc: _descController.text,
                // image: _image?.path ?? '',
                latitude: currentLocation?.latitude ?? 37.421998,
                longitude: currentLocation?.longitude ?? -122.084,
                id: widget.tree.id,
              ),
            );
            result.fold(
              (failure) {
                DisplayMessage.errorMessage(context, failure.toString());
              },
              (success) {
                int count = 0;
                // // AppNavigator.pushReplacement(context, const ProfileScreen());
                Navigator.popUntil(context, (route) {
                  count++;
                  return count == 3;
                });
                // Navigator.pop(context);
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
