import 'package:flutter/material.dart';
import 'package:lecognition/core/constant/api_urls.dart';
import 'package:lecognition/domain/disease/entities/disease_detail.dart';
import 'package:lecognition/presentation/home/pages/home.dart';
import 'package:lecognition/widgets/appbar.dart';
import 'package:lecognition/domain/disease/entities/disease.dart';
import 'package:lecognition/presentation/home/pages/disease.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HistoryDetailScreen extends StatefulWidget {
  final String imagePath;
  final String plantName;
  final DiseaseEntity disease;
  final int diagnosisNumber;
  late double percentage;

  HistoryDetailScreen({
    super.key,
    required this.imagePath,
    required this.plantName,
    required this.disease,
    required this.diagnosisNumber,
    required this.percentage,
  });

  @override
  State<HistoryDetailScreen> createState() => _HistoryDetailScreenState();
}

class _HistoryDetailScreenState extends State<HistoryDetailScreen> {
  bool isShowPercentage = false;

  DiseaseEntity _findDisease(int diseaseId) {
    print("Disease ID: $diseaseId");
    for (var disease in HomeScreen.localDiseasesData) {
      print("Disease ID Looping Now ${disease.id} == $diseaseId ?");
      if (disease.id == diseaseId) {
        return disease;
      }
    }
    final DiseaseEntity returnedDisease = DiseaseEntity(
      id: 5,
      name: 'Penyakit Tidak Diketahui',
      desc: 'Penyakit ini tidak ditemukan dalam database kami.',
    );
    returnedDisease.detail = diseaseDetails.firstWhere(
      (detail) => detail.id == returnedDisease.id,
      orElse: null,
    );
    return returnedDisease;
  }

  @override
  Widget build(BuildContext context) {
    print('penyakit: ${widget.disease.name}');
    print('persentase: ${widget.percentage}');
    final DiseaseEntity disease = _findDisease(widget.disease.id!);
    return Scaffold(
      appBar: AppBarWidget(
        title: '${widget.diagnosisNumber + 1} - ${widget.disease.name}',
      ),
      body: ListView(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
        children: [
          Stack(children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: Image.network(
                    ApiUrls.baseUrlWithoutApi + widget.imagePath.substring(1),
                  ).image,
                  fit: BoxFit.cover,
                ),
              ),
              margin: const EdgeInsets.only(bottom: 15),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width * 1.2,
            ),
            Positioned(
              bottom: 30,
              right: 20,
              child: Column(
                children: [
                  if (isShowPercentage)
                    AnimatedOpacity(
                      opacity: isShowPercentage ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 5000),
                      child: AnimatedSize(
                        duration: const Duration(milliseconds: 5000),
                        curve: Curves.easeInOut,
                        child: isShowPercentage
                            ? Container(
                                padding: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimary
                                      .withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: CircularPercentIndicator(
                                  radius: 50.0,
                                  lineWidth: 11.0,
                                  percent: widget.percentage / 100,
                                  animation: true,
                                  animationDuration: 1000,
                                  center: Text(
                                    (widget.percentage == 100)
                                        ? "100%"
                                        : "${(widget.percentage).toStringAsFixed(2)}%",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                  circularStrokeCap: CircularStrokeCap.round,
                                  progressColor:
                                      Theme.of(context).colorScheme.primary,
                                ),
                              )
                            : SizedBox.shrink(),
                      ),
                    ),
                  SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isShowPercentage = !isShowPercentage;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Akurasi",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Icon(
                            isShowPercentage
                                ? Icons.arrow_drop_down
                                : Icons.arrow_drop_up,
                            size: 25,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimary,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ListTile(
              title: Text(
                widget.disease.id == 1
                    ? "Tanamanmu Sehat"
                    : "Tanamanmu Sedang Sakit :(",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: widget.disease.id == 1
                  ? Text(
                      "Tidak ada penyakit terdeteksi",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.green,
                      ),
                    )
                  : Text(
                      "Terkena Penyakit ${widget.disease.name}!",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.red,
                      ),
                    ),
            ),
          ),
          SizedBox(height: 20),
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
                padding:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10),
                child: Center(
                  child: Text(
                    'Detail',
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
    );
  }
}
