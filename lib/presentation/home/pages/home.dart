import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lecognition/common/widgets/tabs.dart';
import 'package:lecognition/domain/disease/entities/disease.dart';
import 'package:lecognition/domain/disease/entities/disease_detail.dart';
import 'package:lecognition/presentation/bookmark/pages/bookmarked.dart';
import 'package:lecognition/presentation/home/bloc/disease_cubit.dart';
import 'package:lecognition/presentation/home/bloc/disease_state.dart';
import 'package:lecognition/widgets/diseaseCard.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void linkDiseaseDetails(List<DiseaseEntity> diseases) {
    for (var disease in diseases) {
      disease.detail = diseaseDetails.firstWhere(
        (detail) => detail.id == disease.id,
        orElse: null,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DiseaseCubit()..getAllDiseases(),
      child: BlocBuilder<DiseaseCubit, DiseaseState>(
        builder: (context, state) {
          return Skeletonizer(
            enabled: state is DiseasesLoading,
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: MediaQuery.of(context).size.width / 2.2,
                  floating: true,
                  backgroundColor: Colors.transparent,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width / 2,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(70),
                              bottomRight: Radius.circular(70),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: 200,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Selamat Datang Handoko!',
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      // height: 50,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      width: 200,
                                      child: Row(
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
                                                          Navigator.of(context)
                                                              .pop();
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
                                              size: 30,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      TabsScreen(index: 1),
                                                ),
                                              );
                                            },
                                            icon: Icon(Icons.camera_alt_outlined,
                                                color: Colors.white, size: 30),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      BookmarkedScreen(),
                                                ),
                                              );
                                            },
                                            icon: Icon(
                                              Icons.bookmark_outline,
                                              color: Colors.white,
                                              size: 30,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Image(image:
                                AssetImage('assets/avatars/Avatar_3.png'),
                                width: MediaQuery.of(context).size.width / 2.5,
                                // height: 182,
                                // fit: BoxFit.contain,
                                alignment: Alignment.bottomLeft,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (state is DiseasesFailureLoad)
                  SliverFillRemaining(
                    child: Center(
                      child: Text(
                        state.errorMessage,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ),
                  ),
                if (state is DiseasesLoaded)
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        linkDiseaseDetails(state.diseases);
                        final disease = state.diseases[index];
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
                      childCount: state.diseases.length,
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
