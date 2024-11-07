import 'package:flutter/material.dart';
import 'package:lecognition/common/widgets/appbar.dart';
import 'package:lecognition/core/configs/assets/app_images.dart';
import 'package:lecognition/domain/disease/entities/disease.dart';

class DiseaseScreen extends StatelessWidget {
  DiseaseScreen({
    super.key,
    required this.disease,
  });

  final DiseaseEntity disease;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: disease.name.toString(),
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
            child: Hero(
              tag: "photo_${disease.id}",
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18.0),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      AppImages.basePathDisease +
                          disease.id.toString() +
                          ".jpg",
                    ),
                    onError: (exception, stackTrace) {
                      print('Error loading image: $exception');
                      print('Error loading image: $exception');
                    },
                  ),
                ),
              ),
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
                disease.name.toString(), // Display the passed disease name
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                disease.desc
                    .toString(), // Display the passed disease description
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
