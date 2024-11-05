import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:lecognition/common/widgets/tabs.dart';
import 'package:lecognition/models/disease.dart';
import 'package:lecognition/presentation/bookmark/pages/bookmarked.dart';
import 'package:lecognition/widgets/diseaseCard.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:http/http.dart' as http;

import '';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Disease> _diseases = [];
  bool _isLoading = true; // loading animation
  String? _error;

  @override
  void initState() {
    super.initState();
    initialization();
    _loadDiseases();
  }

  void _loadDiseases() async {
    try {
      final url = Uri.http("10.0.2.2:8000", "/api/disease");
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode >= 400) {
        if (mounted) {
          setState(() {
            _error = "Failed to fetch data, please try again later :(";
          });
        }
        return;
      }

      if (response.body == "null") {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
        return;
      }

      final List listData = json.decode(response.body);
      final List<Disease> _loadedItems = [];

      for (final item in listData) {
        _loadedItems.add(
          Disease(
            diseaseId: item["id"],
            diseaseName: item["name"],
            description: item["desc"],
          ),
        );
      }

      if (mounted) {
        setState(() {
          _diseases = _loadedItems;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = "Something went wrong, please try again :(";
        });
      }
    }
  }

  void initialization() async {
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    // Add any necessary cleanup here if using other async listeners.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(_error);
    return Skeletonizer(
      enabled: _isLoading,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.width / 2.2,
            floating: true,
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              background: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width / 2,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(70),
                          bottomRight: Radius.circular(70)),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Center(
                          child: AutoSizeText(
                            "Selamat Datang Lukman!",
                            minFontSize: 35,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Informasi'),
                                      content: const Text(
                                          'Gunakan menu diagnozer untuk mendeteksi penyakit tanaman mangga berdasarkan daunnya.'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              icon: Icon(
                                Icons.info_outline,
                                color: Colors.white,
                                size: 35,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).colorScheme.secondary.withOpacity(0.3), // Warna lingkaran di belakang tombol kamera
                              ),
                              padding: const EdgeInsets.all(0), // Padding untuk membuat lingkaran lebih besar
                              child: IconButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => TabsScreen(index: 1)),
                                  );
                                },
                                icon: Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.white,
                                  size: 50, // Ukuran lebih besar untuk tombol kamera
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BookmarkedScreen())
                                );
                              },
                              icon: Icon(
                                Icons.bookmark,
                                color: Colors.white,
                                size: 35,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                final disease = _diseases[index];
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: index == 0 ? 25.0 : 15.0,
                        left: 16.0,
                        right: 16.0,
                        bottom: index == 0 ? 10 : 10,
                      ),
                      child: DiseaseCard(
                        disease: disease,
                      ),
                    ),

                    // Menambahkan Divider sebagai garis bawah
                    Divider(
                      color: Theme.of(context)
                          .colorScheme
                          .secondary, // Warna garis bawah
                      thickness: 1.0, // Ketebalan garis
                      height: 1.0, // Jarak vertikal garis
                    ),
                  ],
                );
              },
              childCount: _diseases.length, // Sesuaikan dengan jumlah diagnosis
            ),
          ),
        ],
      ),
    );
  }
}
