import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:auto_size_text/auto_size_text.dart';
// import 'package:lecognition/data/dummy_disease.dart';
import 'package:lecognition/models/disease.dart';
import 'package:lecognition/widgets/diseaseCard.dart';
import 'package:lecognition/widgets/tabs.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:http/http.dart' as http;

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
      print("Fetching data from: $url"); // Log the URL
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          // "Authorization": "Bearer <your-token>",
        },
      );

      print(
        "Response status: ${response.statusCode}",
      ); // Log the response status

      if (response.statusCode >= 400) {
        setState(() {
          _error = "Failed to fetch data, please try again later :(";
        });
        return;
      }
      
      print(response.body); // Log the response body for debugging

      if (response.body == "null") {
        setState(() {
          _isLoading = false;
        });
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

      setState(() {
        _diseases = _loadedItems;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = "Something went wrong, please try again :(";
      });
      print("Error: $e"); // Log any caught errors
    }
  }

  void initialization() async {
    await Future.delayed(const Duration(seconds: 1));
    // FlutterNativeSplash.remove(); // Remove splash screen
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _isLoading = false;
    });
    // _loadDiseases();
  }

  @override
  Widget build(BuildContext context) {
    print(_error);
    return Skeletonizer(
      enabled: _isLoading,
      child:
          // _isLoading
          //     ? const Center(
          //         child: SpinKitSquareCircle(
          //           color: Colors.green,
          //           size: 50.0,
          //         ),
          //       )
          //     :
          CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.width / 2,
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
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
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
                                  size: 40,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TabsScreen(
                                              index: 1,
                                            )),
                                  );
                                },
                                icon: Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/bookmarked');
                                },
                                icon: Icon(
                                  Icons.bookmark,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(
          //     horizontal: 20,
          //     vertical: 10,
          //   ),
          // child:
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
          // ),
        ],
      ),
    );
  }
}
