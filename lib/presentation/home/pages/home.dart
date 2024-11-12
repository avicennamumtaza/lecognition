import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lecognition/common/widgets/tabs.dart';
import 'package:lecognition/domain/bookmark/entities/bookmark.dart';
import 'package:lecognition/domain/disease/entities/disease.dart';
import 'package:lecognition/domain/disease/entities/disease_detail.dart';
import 'package:lecognition/presentation/bookmark/bloc/bookmark_cubit.dart';
import 'package:lecognition/presentation/bookmark/bloc/bookmark_state.dart';
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

  void linkDiseaseBookmarkStatus(
      List<DiseaseEntity> diseases, List<BookmarkEntity> bookmarkedDiseases) {
    for (var disease in diseases) {
      disease.isBookmarked = bookmarkedDiseases.any(
        (bookmark) => bookmark.disease?.id == disease.id,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DiseaseCubit>(
          create: (context) => DiseaseCubit()..getAllDiseases(),
        ),
        BlocProvider<BookmarkCubit>(
          create: (context) => BookmarkCubit()..getAllBookmarkedDiseases(),
        ),
      ],
      child: BlocBuilder<DiseaseCubit, DiseaseState>(
        builder: (context, diseaseState) {
          return BlocBuilder<BookmarkCubit, BookmarkState>(
            builder: (context, bookmarkState) {
              // Memastikan `bookmarkedDiseases` hanya diakses ketika BookmarkCubit berhasil memuat data
              List<BookmarkEntity> bookmarkedDiseases = [];
              if (bookmarkState is BookmarkedDiseasesLoaded &&
                  diseaseState is DiseasesLoaded) {
                bookmarkedDiseases = bookmarkState.bookmarkedDiseases;
                linkDiseaseDetails(diseaseState.diseases);
                linkDiseaseBookmarkStatus(
                    diseaseState.diseases, bookmarkedDiseases);
              }

              return Skeletonizer(
                enabled: diseaseState is DiseasesLoading ||
                    bookmarkState is BookmarkedDiseasesLoading,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    width: 200,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                        SizedBox(height: 50),
                                        Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary
                                                .withOpacity(0.5),
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          width: 200,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: const Text(
                                                            'Informasi'),
                                                        content: const Text(
                                                            'Gunakan menu diagnozer untuk mendeteksi penyakit tanaman mangga berdasarkan daunnya.'),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: const Text(
                                                                'OK'),
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
                                                icon: Icon(
                                                    Icons.camera_alt_outlined,
                                                    color: Colors.white,
                                                    size: 30),
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
                                                  Icons.bookmark,
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
                                  Image(
                                    image: AssetImage(
                                        'assets/avatars/Avatar_3.png'),
                                    width: 219,
                                    alignment: Alignment.bottomLeft,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (diseaseState is DiseasesFailureLoad ||
                        bookmarkState is BookmarkedDiseasesFailureLoad)
                      SliverFillRemaining(
                        child: Center(
                          child: Text(
                            // Menampilkan pesan error dari state yang relevan
                            diseaseState is DiseasesFailureLoad
                                ? diseaseState.errorMessage
                                : (bookmarkState
                                        is BookmarkedDiseasesFailureLoad
                                    ? bookmarkState.errorMessage
                                    : 'Unknown error'),
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.error,
                            ),
                          ),
                        ),
                      ),
                    // if (diseaseState is DiseasesFailureLoad ||
                    //     bookmarkState is BookmarkedDiseasesFailureLoad)
                    //   SliverFillRemaining(
                    //     child: Center(
                    //       child: Text(
                    //         diseaseState is DiseasesFailureLoad
                    //             ? diseaseState.errorMessage
                    //             : bookmarkState.errorMessage,
                    //         style: TextStyle(
                    //           color: Theme.of(context).colorScheme.error,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    if (diseaseState is DiseasesLoaded)
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final disease = diseaseState.diseases[index];
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
                                Divider(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  thickness: 1.0,
                                  height: 1.0,
                                ),
                              ],
                            );
                          },
                          childCount: diseaseState.diseases.length,
                        ),
                      ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
