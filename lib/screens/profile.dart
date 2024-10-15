import 'dart:io'; // Digunakan untuk menampilkan gambar dari path
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<String> _imagePaths = [];

  @override
  void initState() {
    super.initState();
    _loadImagePaths();
  }

  // Fungsi untuk mengambil path gambar dari SharedPreferences
  Future<void> _loadImagePaths() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedImages = prefs.getStringList('diagnosis_images') ?? [];

    setState(() {
      _imagePaths = savedImages;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _imagePaths.isEmpty
        ? const Center(
            child: Text('Belum ada diagnosis yang tersimpan.'),
          )
        : ListView.builder(
            itemCount: _imagePaths.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Image.file(
                  File(
                    _imagePaths[index],
                  ),
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                title: Text(
                  'Diagnosis #${index + 1}',
                ),
              );
            },
          );
  }
}
