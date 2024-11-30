import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lecognition/common/widgets/appbar.dart';
import 'package:lecognition/data/diagnozer/models/get_diagnoze_result_params.dart';
// import 'package:lecognition/data/dummy_disease.dart';
import 'package:lecognition/domain/disease/entities/disease.dart';
import 'package:lecognition/domain/disease/entities/disease_detail.dart';
import 'package:lecognition/presentation/diagnozer/bloc/diagnosis_state.dart';
import 'package:lecognition/presentation/diagnozer/bloc/diagnozer_cubit.dart';
import 'package:lecognition/presentation/disease/pages/disease.dart';
import 'package:lecognition/presentation/home/pages/home.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ResultScreen extends StatefulWidget {
  ResultScreen({
    super.key,
    required this.photo,
    required this.plantName, // New parameter
    // required this.diseaseDescription, // New parameter
  });

  final XFile photo;
  final String plantName;
  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  // DiseaseEntity ds = diseases[0];
  // final double percentage = Random().nextDouble();

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
    final photoImg = File(widget.photo.path);
    return Scaffold(
      appBar: AppBarWidget(title: 'Hasil Diagnosis'),
      body: BlocProvider<DiagnozerCubit>(
        create: (context) => DiagnozerCubit()
          ..getDiagnosis(
            GetDiagnosisParams(
              imageFile: widget.photo,
            ),
          ),
        child: BlocBuilder<DiagnozerCubit, DiagnosisState>(
          builder: (context, state) {
            if (state is DiagnosisLoading) {
              return const Center(
                child: SpinKitSquareCircle(
                  color: Colors.green,
                  size: 50.0,
                ),
              );
            }
            if (state is DiagnosisFailureLoad) {
              return Center(
                child: Text(state.errorMessage),
              );
            }
            if (state is DiagnosisLoaded) {
              final double? persentase = state.diagnosis.accuracy;
              print("Persentase: $persentase");
              print("Disease: ${state.diagnosis.disease}");
              return ListView(
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
                    child: Image.file(
                      photoImg,
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
                        state.diagnosis.disease == 1
                            ? "Your plant is healthy"
                            : "Your plant is diseased", // Display the passed disease name
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        "Disease ${state.diagnosis.disease.toString()}", // Display the passed disease description
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
                        percent: persentase!,
                        animation: true,
                        animationDuration: 1000,
                        center: Text(
                          "${(persentase * 100).round()}%",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                        footer: Text(
                          "Persentase Akurasi",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17.0,
                          ),
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
                                  disease:
                                      _findDisease(state.diagnosis.disease!),
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
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16.0, horizontal: 10),
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
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
