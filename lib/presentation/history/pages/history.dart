import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lecognition/presentation/history/bloc/history_cubit.dart';
import 'package:lecognition/presentation/history/bloc/history_state.dart';
import 'package:lecognition/widgets/appbar.dart';
import 'package:lecognition/presentation/history/pages/history_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoriScreen extends StatefulWidget {
  const HistoriScreen({super.key});

  @override
  State<HistoriScreen> createState() => _HistoriScreenState();
}

class _HistoriScreenState extends State<HistoriScreen> {
  List<String> _imagePaths = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedImages = prefs.getStringList('diagnosis_images') ?? [];

    setState(() {
      _imagePaths = savedImages;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HistoryCubit()..getUserHistories(),
      child: BlocBuilder<HistoryCubit, HistoryState>(
        builder: (context, state) {
          if (state is HistoryLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is HistoryFailureLoad) {
            return Center(
              child: Text(state.errorMessage),
            );
          }
          if (state is HistoryLoaded) {
            print('Loaded user histories: ${state.userHistories}');
            return Scaffold(
              appBar: AppBarWidget(title: 'Riwayat Diagnosis'),
              body: _imagePaths.isEmpty || state.userHistories.isEmpty
                ? const Center(
                    child: Text('Belum ada diagnosis yang tersimpan.'),
                  )
                : Scrollbar(
                    interactive: true,
                    thickness: 3,
                    radius: const Radius.circular(5),
                    child: ListView.builder(
                      itemCount: state.userHistories.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ResultHistoryScreen(
                                  imagePath: _imagePaths[index],
                                  disease: state.userHistories[index].disease!,
                                  plantName: state.userHistories[index].tree!.desc!,
                                  percentage: double.parse(state.userHistories[index].accuracy!),
                                  diagnosisNumber: index,
                                ),
                              ),
                            );
                          },
                          child: Card(
                            color: Theme.of(context).colorScheme.onInverseSurface,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start, // Align items to the top
                                    children: [
                                      Hero(
                                        tag: _imagePaths[index],
                                        child: Image.file(
                                          File(_imagePaths[index]),
                                          width: 70,
                                          height: 70,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  'Diagnosis #${index + 1}',
                                                  style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                Text(
                                                  '21-10-2024',
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
