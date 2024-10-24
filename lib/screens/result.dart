import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lecognition/data/dummy_disease.dart';
import 'package:lecognition/models/disease.dart';
import 'package:lecognition/widgets/tabs.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'disease.dart';

class ResultScreen extends StatelessWidget {
  ResultScreen({
    super.key, 
    required this.photo, 
    required this.diseaseName, // New parameter
    required this.diseaseDescription, // New parameter
  });

  final File photo;
  final String diseaseName; // Variable to hold the disease name
  final String diseaseDescription; // Variable to hold the disease description

  Disease ds = diseases[0];
  final double percentage = Random().nextDouble();

  Disease _findDisease() {
    for (var disease in diseases) {
      if (disease.diseaseName == diseaseName) {
        ds = disease;
        break;
      }
    }
    return ds;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: const Text('Result Screen'),
      ),
      body: ListView(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
        children: [

          // Displays the image
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.only(bottom: 15),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
            child: Image.file(
              photo,
              fit: BoxFit.cover,
            ),
          ),

          // Deskripsi Penyakit
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.topLeft,
            child: ListTile(
              title: Text(
                diseaseName, // Display the passed disease name
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                diseaseDescription, // Display the passed disease description
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ),

          // Presentasi Akurasi Model Machine Learning
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Center(
              child: CircularPercentIndicator(
                radius: 70.0,
                lineWidth: 13.0,
                percent: percentage,
                animation: true,
                animationDuration: 1000,
                center: Text(
                  "${(percentage * 100).toStringAsFixed(2)}%",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                footer: Text(
                  "Persentase Akurasi",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),

          // Tombol Aksi
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              // color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DiseaseScreen(
                          disease: _findDisease(),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2.5,
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10),
                      child: Center(
                        child: Text(
                          'Detail Penyakit',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    width: MediaQuery.of(context).size.width / 2.5,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10),
                      child: Center(
                        child: Text(
                          'Gambar Baru',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
