import 'dart:io';
import 'package:flutter/material.dart';

class ResultHistoryScreen extends StatelessWidget {
  final String imagePath;
  final String diseaseName; // Add a field for disease name
  final String diseaseDescription; // Add a field for disease description
  final int diagnosisNumber;

  const ResultHistoryScreen({
    Key? key,
    required this.imagePath,
    required this.diseaseName,
    required this.diseaseDescription,
    required this.diagnosisNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail #${diagnosisNumber + 1}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Image.file(
              File(imagePath),
              width: 300,
              height: 300,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            Text(
              diseaseName, // Display disease name
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              diseaseDescription, // Display disease description
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
