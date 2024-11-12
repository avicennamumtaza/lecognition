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
    print(disease.isBookmarked);
    print(disease.detail);
    print(disease.detail?.treatment);
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
                  fontSize: 17,
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
            child: ListTile(
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
                disease.detail!.treatment.toString(),
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
            child: ListTile(
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
                disease.detail!.prevention.toString(),
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
            child: ListTile(
              title: Text(
                'Level Bahaya',
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
                disease.detail!.severity.toString(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
