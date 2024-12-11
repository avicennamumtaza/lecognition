import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lecognition/widgets/appbar.dart';
import 'package:lecognition/domain/disease/entities/disease.dart';
import 'package:lecognition/presentation/home/pages/disease.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ResultHistoryScreen extends StatelessWidget {
  final String imagePath;
  final String plantName;
  final DiseaseEntity disease;
  final int diagnosisNumber;
  final double percentage;

  ResultHistoryScreen({
    Key? key,
    required this.imagePath,
    required this.plantName,
    required this.disease,
    required this.diagnosisNumber,
    required this.percentage,
  }) : super(key: key);

  // DiseaseEntity ds = HomeScreen.localDiseasesData[0];
  // DiseaseEntity _findDisease() {
  //   for (var disease in HomeScreen.localDiseasesData) {
  //     if (disease.id == diseaseId) {
  //       ds = disease;
  //       break;
  //     }
  //   }
  //   return ds;
  // }

  @override
  Widget build(BuildContext context) {
    // DiseaseEntity disease = _findDisease();
    return Scaffold(
      appBar: AppBarWidget(
        title: 'Diagnosis #${diagnosisNumber + 1} - ${disease.name}',
      ),
      body: ListView(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.only(bottom: 15),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
            child: Hero(
              tag: imagePath,
              child: Image.file(
                File(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Container(
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.topLeft,
            child: ListTile(
              title: Text(
                "${disease.name}", // Display the passed disease name
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // subtitle: Text(
              //   diseaseDescription, // Display the passed disease description
              //   style: const TextStyle(
              //     fontSize: 15,
              //   ),
              // ),
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
                          disease: disease,
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 10),
                      child: Center(
                        child: Text(
                          'Detail Penyakit',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onPrimary,
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
