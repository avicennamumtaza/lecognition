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
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return _showImage(context);
                },
              );
            },
            child: Container(
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
                    borderRadius: BorderRadius.circular(10.0),
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
          ),
          // Deskripsi Penyakit
          _descriptionCard(title: disease.name.toString(), subtitle: disease.desc.toString(), context: context),
          // Pengobatan
          _descriptionCard(title: 'Pengobatan', subtitle: disease.detail!.treatment.toString(), context: context),
          // Pencegahan
          _descriptionCard(title: 'Pencegahan', subtitle: disease.detail!.prevention.toString(), context: context),
          // Level Bahaya
          _descriptionCard(title: 'Level Bahaya', subtitle: disease.detail!.severity.toString(), context: context)
        ],
      ),
    );
  }

  Widget _descriptionCard({
    required String title,
    required String subtitle,
    required BuildContext context,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.topLeft,
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          style: TextStyle(
            fontSize: 17,
          ),
          subtitle,
        ),
      ),
    );
  }

  Widget _showImage(BuildContext context) {
    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 2.2,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              AppImages.basePathDisease +
                  disease.id.toString() +
                  ".jpg",
            ),
            onError: (exception, stackTrace) {
              print('Error loading image: $exception');
            },
          ),
        ),
      ),
    );
  }
}
