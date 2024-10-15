import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lecognition/data/dummy_disease.dart';
import 'dart:math';
import 'package:percent_indicator/percent_indicator.dart';

class ResultScreen extends StatelessWidget {
  ResultScreen({super.key, required this.photo});
  final File photo;
  int index = Random().nextInt(diseases.length - 2);

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
                diseases[index].diseaseName,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                diseases[index].description,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ),
          // Pengobatan
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.topLeft,
            child: const ListTile(
              title: Text(
                'Pengobatan',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                style: TextStyle(
                  fontSize: 17,
                ),
                'Pengobatan penyakit ini dapat dilakukan dengan cara:\n'
                    '1. Menyemprotkan pestisida\n'
                    '2. Pangkas bagian yang terinfeksi\n'
                    '3. Pengelolaan lingkungan\n'
                    '4. Penggunaan pestisida organik\n'
                    '5. Peningkatan nutrisi tanaman\n'
                    '6. Pemantauan rutin\n',
              ),
            ),
          ),
          // Pencegahan
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.topLeft,
            child: const ListTile(
              title: Text(
                'Pencegahan',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                style: TextStyle(
                  fontSize: 17,
                ),
                'Pencegahan penyakit ini dapat dilakukan dengan cara:\n'
                    '1. Menjaga kebersihan tanaman\n'
                    '2. Menyemprotkan pestisida\n'
                    '3. Menyiram tanaman secara teratur\n'
                    '4. Menyediakan nutrisi yang cukup untuk tanaman\n'
                    '5. Menyediakan cahaya yang cukup untuk tanaman\n'
                    '6. Menyediakan air yang cukup untuk tanaman\n'
                    '7. Menyediakan udara yang cukup untuk tanaman\n',
              ),
            ),
          ),
          // Informasi Tambahan
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.topLeft,
            child: const ListTile(
              title: Text(
                'Tambahan',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 17,
                ),
                'Pantau tanaman secara rutin setelah pengobatan pertama. Jika gejala tidak berkurang, '
                'pertimbangkan untuk mengaplikasikan fungisida sistemik dengan bahan aktif berbeda atau '
                'konsultasi dengan ahli pertanian setempat',
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
              child: new CircularPercentIndicator(
                radius: 70.0,
                lineWidth: 13.0,
                percent: 0.735,
                animation: true,
                animationDuration: 1000,
                center: new Text(
                  "73.5%",
                  style:
                  new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                footer: new Text(
                  "Presentase Akurasi",
                  style:
                  new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}