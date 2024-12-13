import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lecognition/core/constant/api_urls.dart';
import 'package:lecognition/domain/disease/entities/disease.dart';
import 'package:lecognition/domain/disease/entities/disease_detail.dart';
import 'package:lecognition/presentation/home/pages/disease.dart';
import 'package:lecognition/widgets/appbar.dart';
import 'package:lecognition/data/diagnozer/models/get_diagnoze_result_params.dart';
import 'package:lecognition/presentation/diagnozer/bloc/diagnosis_state.dart';
import 'package:lecognition/presentation/diagnozer/bloc/diagnozer_cubit.dart';
import 'package:lecognition/presentation/home/pages/home.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ResultScreen extends StatefulWidget {
  ResultScreen({
    super.key,
    required this.photo,
    required this.treeId, // New parameter
    // required this.diseaseDescription, // New parameter
  });

  final XFile photo;
  final int treeId;
  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  // DiseaseEntity ds = diseases[0];
  // final double percentage = Random().nextDouble();
  bool isShowPercentage = false;
  // bool isSaved = false;

  /////////////////////////////////////////////
  /////////////////////////////////////////////
  // Future<File> _saveImageLocally(File imageFile) async {
  //   try {
  //     final directory = await getApplicationDocumentsDirectory();
  //     final fileName = imageFile.path.split('/').last;
  //     final newImagePath = '${directory.path}/$fileName';
  //     final newImage = await imageFile.copy(newImagePath);
  //     print('Image saved locally: $newImagePath');
  //     return newImage;
  //   } catch (e) {
  //     throw Exception('Error saat menyimpan gambar: $e');
  //   }
  // }

  // Future<void> _saveDiagnosis(File image) async {
  //   final plantName = "nama mangga";

  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   List<String>? savedImages = prefs.getStringList('diagnosis_images') ?? [];
  //   List<String>? savedPlantNames = prefs.getStringList('plant_names') ?? [];

  //   savedImages.add(image.path);
  //   savedPlantNames.add(plantName);

  //   print("savedPlantNames: $savedPlantNames");
  //   print("savedImages: $savedImages");

  //   await prefs.setStringList('diagnosis_images', savedImages);
  //   await prefs.setStringList('plant_names', savedPlantNames);
  // }
  /////////////////////////////////////////////
  /////////////////////////////////////////////

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

  // void saveDiagosisResult(
  //   int idResultedDisease,
  //   double percentageResultedDisease,
  // ) async {
  //   print("Resulted Disease: $idResultedDisease $percentageResultedDisease%");
  //   SharedPreferences prefs = await SharedPreferences.getInstance();

  //   List<String>? savedResults = prefs.getStringList('diagnosis_result') ?? [];
  //   savedResults.add(idResultedDisease.toString());
  //   await prefs.setStringList('diagnosis_result', savedResults);
  //   print('Saved results: $savedResults');

  //   List<String>? savedPercentages =
  //       prefs.getStringList('diagnosis_percentage') ?? [];
  //   savedPercentages.add(percentageResultedDisease.toString());
  //   await prefs.setStringList('diagnosis_percentage', savedPercentages);
  //   print('Saved percentages: $savedPercentages');
  // }

  void showPercentage() async {
    print('Show Percentage ${isShowPercentage}');
    setState(() {
      isShowPercentage = !isShowPercentage;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final photoImg = File(widget.photo.path);
    if (HomeScreen.localDiseasesData.isEmpty) {
      return Center(
        child: Text(
          "Data penyakit tidak ditemukan",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      );
    }
    // print("IIIIIIIIIIIDDDDDDDDDDDDDDD TTTTTTTTTRRRRRRRRRRRREEEEEEEEEEEEEEEEEEEEEEEEEEEEE ${widget.treeId}");
    return Scaffold(
      appBar: AppBarWidget(title: 'Hasil Diagnosis'),
      body: BlocProvider<DiagnozerCubit>(
        create: (context) => DiagnozerCubit()
          ..getDiagnosis(
            GetDiagnosisParams(
              imageFile: widget.photo,
              treeId: widget.treeId,
            ),
          ),
        child: BlocBuilder<DiagnozerCubit, DiagnosisState>(
          builder: (context, state) {
            // if (state is DiagnosisLoading) {
            // print("Persentase: $persentase");
            //   print("Disease: ${state.diagnosis.disease}");
            // print(
            //   "Path gambar: ${widget.photo.path}",
            // );
            // print(
            //   "Apakah file ada? ${File(
            //     widget.photo.path,
            //   ).existsSync()}",
            // );
            // }
            if (state is DiagnosisFailureLoad) {
              return Center(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // ListTile(
                    Icon(
                      Icons.error_outline,
                      size: 100,
                      color: Colors.red,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Proses diagnosis gagal :(",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.red[900],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 5),
                    state.errorMessage.isNotEmpty
                        ? Text(
                            "${state.errorMessage}\nSilahkan coba lagi dengan lebih fokus ke satu objek daun atau pilih foto lain.",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.red[900],
                            ),
                            textAlign: TextAlign.center,
                          )
                        : SizedBox.shrink(),
                    // ),
                    SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
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
                        child: Text(
                          'Coba lagi',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ));
            }
            if (state is DiagnosisLoaded) {
              try {
                final double? persentase = state.diagnosis.accuracy;
                // print("Persentase: $persentase");
                // print("Disease: ${state.diagnosis.disease}");
                // print("Path gambar: ${widget.photo.path}");
                // print(
                //   "Apakah file ada? ${File(
                //     widget.photo.path,
                //   ).existsSync()}",
                // );
                // if (isSaved == false) {
                //   _saveDiagnosis(photoImg);
                //   _saveImageLocally(photoImg);
                //   saveDiagosisResult(state.diagnosis.disease!, persentase!);
                //   isSaved = true;
                // }
                // _saveDiagnosis(photoImg);
                // _saveImageLocally(photoImg);
                // saveDiagosisResult(state.diagnosis.disease!, persentase!);
                final DiseaseEntity disease =
                    _findDisease(state.diagnosis.disease!);
                print(
                  "URL DIAGNOSIS IMAGE: ${ApiUrls.baseUrlWithoutApi + state.diagnosis.img!.substring(1)}",
                );
                return ListView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  children: [
                    Stack(children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: Image.network(
                              ApiUrls.baseUrlWithoutApi +
                                  state.diagnosis.img!.substring(1),
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
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary
                                                .withOpacity(0.5),
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                          child: CircularPercentIndicator(
                                            radius: 45.0,
                                            lineWidth: 13.0,
                                            percent: persentase!,
                                            animation: true,
                                            animationDuration: 1000,
                                            center: Text(
                                              "${(persentase * 100).round()}%",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20.0,
                                              ),
                                            ),
                                            circularStrokeCap:
                                                CircularStrokeCap.round,
                                            progressColor: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                        )
                                      : SizedBox.shrink(),
                                ),
                              ),
                            SizedBox(height: 10),
                            InkWell(
                              onTap: () {
                                showPercentage();
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
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                      ),
                                    ),
                                    Icon(
                                      isShowPercentage
                                          ? Icons.arrow_drop_down
                                          : Icons.arrow_drop_up,
                                      size: 25,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
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
                          state.diagnosis.disease == 1
                              ? "Tanamanmu Sehat"
                              : "Tanamanmu Sedang Sakit :(",
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: state.diagnosis.disease == 1
                            ? Text(
                                "Tidak ada penyakit terdeteksi",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.green,
                                ),
                              )
                            : Text(
                                "Terkena Penyakit ${disease.name}!",
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
                          padding: const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 10),
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
                );
              } catch (e) {
                return Center(
                  child: Text(
                    "Terjadi kesalahan saat menampilkan hasil diagnosis $e",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }
            }
            return Center(
              child: SpinKitSquareCircle(
                color: Theme.of(context).colorScheme.onPrimary,
                size: 50.0,
              ),
            );
          },
        ),
      ),
    );
  }
}
