import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lecognition/domain/disease/entities/disease.dart';
import 'package:lecognition/domain/disease/entities/disease_detail.dart';
import 'package:lecognition/presentation/home/pages/disease.dart';
import 'package:lecognition/widgets/appbar.dart';
import 'package:lecognition/data/diagnozer/models/get_diagnoze_result_params.dart';
import 'package:lecognition/presentation/diagnozer/bloc/diagnosis_state.dart';
import 'package:lecognition/presentation/diagnozer/bloc/diagnozer_cubit.dart';
import 'package:lecognition/presentation/home/pages/home.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ResultScreen extends StatefulWidget {
  ResultScreen({
    super.key,
    required this.photo,
    required this.treeId,
  });

  final XFile photo;
  final int treeId;
  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
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

  void showPercentage() async {
    print('Show Percentage ${isShowPercentage}');
    setState(() {
      isShowPercentage = !isShowPercentage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (HomeScreen.localDiseasesData.isEmpty) {
      return Center(
        child: Text(
          "Data penyakit tidak ditemukan",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      );
    }
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
            if (state is DiagnosisFailureLoad) {
              return Center(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 45),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 100,
                      color: Colors.red,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Diagnosis Gagal :(",
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
                            "${state.errorMessage}\nSilahkan coba foto lain dengan lebih fokus pada satu objek daun mangga.",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.red[900],
                            ),
                            textAlign: TextAlign.center,
                          )
                        : SizedBox.shrink(),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Coba lagi',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          // color: Colors.black,
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
                final DiseaseEntity disease =
                    _findDisease(state.diagnosis.disease!);
                return ListView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  children: [
                    Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: FileImage(File(widget.photo.path)),
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
                                    duration:
                                        const Duration(milliseconds: 5000),
                                    curve: Curves.easeInOut,
                                    child: isShowPercentage
                                        ? Container(
                                            padding: const EdgeInsets.all(3),
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimary
                                                  .withOpacity(0.5),
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                            child: CircularPercentIndicator(
                                              radius: 50.0,
                                              lineWidth: 11.0,
                                              percent: persentase!,
                                              animation: true,
                                              animationDuration: 1000,
                                              center: Text(
                                                (persentase == 100)
                                                    ? "100%"
                                                    : "${(persentase * 100).toStringAsFixed(2)}%",
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
                                    color:
                                        Theme.of(context).colorScheme.primary,
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
                      ],
                    ),
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
                                "Penyakit ${disease.name}!",
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
