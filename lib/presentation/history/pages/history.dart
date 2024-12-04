import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lecognition/common/widgets/appbar.dart';
import 'package:lecognition/presentation/history/pages/history_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoriScreen extends StatefulWidget {
  const HistoriScreen({super.key});

  @override
  State<HistoriScreen> createState() => _HistoriScreenState();
}

class _HistoriScreenState extends State<HistoriScreen> {
  List<String> _imagePaths = [];
  List<String> _plantNames = [];
  List<String> _diseaseId = []; // List for disease names
  List<String> _percentages = []; // List for disease percentages
  // List<String> _diseaseDescriptions = []; // List for disease descriptions

  @override
  void initState() {
    super.initState();
    _loadData(); // Load all relevant data
  }

  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedImages = prefs.getStringList('diagnosis_images') ?? [];
    List<String>? savedPlantNames = prefs.getStringList('plant_names') ?? [];
    List<String>? savedResults = prefs.getStringList('diagnosis_result') ?? [];
    List<String>? savedPercentages = prefs.getStringList('diagnosis_percentage') ?? [];

    setState(() {
      _imagePaths = savedImages;
      _plantNames = savedPlantNames;
      _diseaseId = savedResults;
      _percentages = savedPercentages;
      // _diseaseDescriptions = savedDescriptions;
    });

    print('Loaded image paths: $_imagePaths');
    print('Loaded plant names: $_plantNames');
    print('Loaded resulted disease id: $_diseaseId');
    print('Loaded resulted disease percentage: $_percentages');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'Histori Diagnosa'), // Use custom appbar
      body: _imagePaths.isEmpty
          ? const Center(
        child: Text('Belum ada diagnosis yang tersimpan.'),
      )
          : Scrollbar(
        interactive: true,
        thickness: 3,
        radius: const Radius.circular(5),
        child: ListView.builder(
          itemCount: _imagePaths.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // Navigate to detail screen when tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultHistoryScreen(
                      imagePath: _imagePaths[index],
                      diseaseId: int.parse(_diseaseId[index]),
                      plantName: _plantNames[index],
                      percentage: double.parse(_percentages[index]),
                      diagnosisNumber: index,
                    ),
                  ),
                );
              },
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0), // 16px padding from all sides
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start, // Align items to the top
                        children: [
                          // Image placed on the top-left of the card
                          Hero(
                            tag: _imagePaths[index], // Unique tag for each image
                            child: Image.file(
                              File(_imagePaths[index]),
                              width: 70,
                              height: 70,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 10), // Space between image and text
                          // Column for text
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '#${index + 1} Disease ke-${_diseaseId[index]}', // Diagnosis name
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      '21-10-2024', // Static date, replace with actual if needed
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                // Text(
                                //   _diseaseDescriptions[index], // Disease description
                                //   style: const TextStyle(fontSize: 14),
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
