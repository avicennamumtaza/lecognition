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
import 'package:lecognition/presentation/profile/bloc/user_cubit.dart';
import 'package:lecognition/presentation/profile/bloc/user_state.dart';
import 'package:lecognition/widgets/disease_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static List<DiseaseEntity> localDiseasesData = [];

  void linkDiseaseDetails(List<DiseaseEntity> diseases) {
    for (var disease in diseases) {
      disease.detail = diseaseDetails.firstWhere(
        (detail) => detail.id == disease.id,
        orElse: null,
      );
    }
  }

  void linkDiseaseBookmarkStatus(
    List<DiseaseEntity> diseases,
    List<BookmarkEntity> bookmarkedDiseases,
  ) {
    for (var disease in diseases) {
      disease.isBookmarked = bookmarkedDiseases.any(
        (bookmark) => bookmark.disease?.id == disease.id,
      );
      if (disease.isBookmarked == true) {
        disease.idBookmarked = bookmarkedDiseases
            .firstWhere((bookmark) => bookmark.disease?.id == disease.id)
            .id;
      }
      localDiseasesData.add(disease);
      print(localDiseasesData);
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
        BlocProvider<UserCubit>(
          create: (context) => UserCubit()..getUserProfile(),
        ),
      ],
      child: BlocBuilder<UserCubit, UserState>(
        builder: (context, userState) {
          return BlocBuilder<DiseaseCubit, DiseaseState>(
            builder: (context, diseaseState) {
              return BlocBuilder<BookmarkCubit, BookmarkState>(
                builder: (context, bookmarkState) {
                  List<BookmarkEntity> bookmarkedDiseases = [];
                  if (bookmarkState is BookmarkedDiseasesLoaded &&
                      diseaseState is DiseasesLoaded &&
                      userState is UserLoaded) {
                    bookmarkedDiseases = bookmarkState.bookmarkedDiseases;
                    linkDiseaseDetails(diseaseState.diseases);
                    linkDiseaseBookmarkStatus(
                      diseaseState.diseases,
                      bookmarkedDiseases,
                    );
                  }

                  return Skeletonizer(
                    enabled: diseaseState is DiseasesLoading ||
                        bookmarkState is BookmarkedDiseasesLoading ||
                        userState is UserLoading,
                    child: SingleChildScrollView(
                      child: Container(
                        child: Column(
                          children: [
                            if (userState is UserLoaded)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 0,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: "Selamat Datang,\n",
                                              style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white,),
                                            ),
                                            TextSpan(
                                              text: userState.user.username!.toUpperCase(),
                                              style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white, fontWeight: FontWeight.w600,),
                                            )
                                          ],
                                        )
                                      ),
                                      _showAvatar(context, userState.user.avatar!),
                                  ],
                                ),
                              ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                                color: Colors.white,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 20,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _actionButton(context),
                                  SizedBox(height: 10),
                                  Text(
                                    'Daftar Penyakit',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  if (diseaseState is DiseasesFailureLoad || bookmarkState is BookmarkedDiseasesFailureLoad || userState is UserFailureLoad)
                                    Container(
                                      child: Center(
                                        child: Text(
                                          diseaseState is DiseasesFailureLoad
                                              ? diseaseState.errorMessage
                                              : (bookmarkState is BookmarkedDiseasesFailureLoad
                                              ? bookmarkState.errorMessage
                                              : userState is UserFailureLoad
                                              ? userState.errorMessage
                                              : 'Terjadi kesalahan'),
                                          style: TextStyle(
                                            color: Theme.of(context).colorScheme.error,
                                          ),
                                        ),
                                      ),
                                    ),
                                  if (diseaseState is DiseasesLoaded)
                                    for (var disease in diseaseState.diseases)
                                      Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                              top:  15.0,
                                              bottom: 10,
                                            ),
                                            child: DiseaseCard(
                                              disease: disease,
                                            ),
                                          ),
                                          Divider(
                                            color: Theme.of(context).colorScheme.onSecondary.withOpacity(0.5),
                                            thickness: 1.0,
                                            height: 1.0,
                                          ),
                                        ],
                                      ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget _actionButton(BuildContext context) {
    return Container(
        height: 100,
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TabsScreen(index: 1),
                  ),
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 2.4,
                height: 70,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.camera_alt_outlined,
                      size: 50,
                    ),
                    SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Diagnosis',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          'Tanamanmu',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(width: 10),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookmarkedScreen(),
                  ),
                ).then((_) {
                  BlocProvider.of<BookmarkCubit>(context)
                      .getAllBookmarkedDiseases();
                });
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 2.4,
                height: 70,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.save_outlined,
                      size: 50,
                    ),
                    SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tersimpan',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          'Penyakit',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
    );
  }

  Widget _showAvatar(BuildContext context, int idAvatar) {
    return Image(
      image: AssetImage('assets/avatars/Avatar_$idAvatar.png'),
      width: MediaQuery.of(context).size.width / 2,
      alignment: Alignment.bottomLeft,
    );
  }
}
