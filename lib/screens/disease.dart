import 'package:flutter/material.dart';
import 'package:lecognition/models/disease.dart';

class DiseaseScreen extends StatelessWidget {
  DiseaseScreen({
    super.key,
    required this.disease,
  });

  final Disease disease;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        // title: const Text('Disease Details'),
        title: Text(disease.diseaseName),
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
            height: MediaQuery.of(context).size.height / 3.5,
            child: Image.network(
              "https://halosehat.com/wp-content/uploads/2019/05/manfaat-daun-mangga-696x395.jpg",
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
                disease.diseaseName, // Display the passed disease name
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                disease.description, // Display the passed disease description
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
                'Informasi Tambahan',
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
        ],
      ),
    );
  }
}
