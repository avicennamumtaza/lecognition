import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lecognition/screens/result_history.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<String> _imagePaths = [];
  List<String> _diseaseNames = []; // List for disease names
  List<String> _diseaseDescriptions = []; // List for disease descriptions

  @override
  void initState() {
    super.initState();
    _loadData(); // Load all relevant data
  }

  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedImages = prefs.getStringList('diagnosis_images') ?? [];
    List<String>? savedNames = prefs.getStringList('diagnosis_names') ?? [];
    List<String>? savedDescriptions =
        prefs.getStringList('diagnosis_descriptions') ?? [];

    setState(() {
      _imagePaths = savedImages;
      _diseaseNames = savedNames;
      _diseaseDescriptions = savedDescriptions;
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
                  File(_imagePaths[index]),
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                title: Text(
                  'Diagnosis #${index + 1}: ${_diseaseNames[index]}', // Show diagnosis name
                ),
                onTap: () {
                  // Navigate to detail screen when tapped
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResultHistoryScreen(
                        imagePath: _imagePaths[index],
                        diseaseName: _diseaseNames[index], // Pass disease name
                        diseaseDescription: _diseaseDescriptions[
                            index], // Pass disease description
                        diagnosisNumber: index,
                      ),
                    ),
                  );
                },
              );
            },
          );
  }
}
