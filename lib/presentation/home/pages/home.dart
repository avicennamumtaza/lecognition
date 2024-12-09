import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lecognition/common/helper/navigation/app_navigator.dart';
import 'package:lecognition/common/widgets/tabs.dart';
import 'package:lecognition/domain/bookmark/entities/bookmark.dart';
import 'package:lecognition/domain/disease/entities/disease.dart';
import 'package:lecognition/domain/disease/entities/disease_detail.dart';
import 'package:lecognition/presentation/bookmark/bloc/bookmark_cubit.dart';
import 'package:lecognition/presentation/bookmark/bloc/bookmark_state.dart';
import 'package:lecognition/presentation/home/bloc/disease_cubit.dart';
import 'package:lecognition/presentation/home/bloc/disease_state.dart';
import 'package:lecognition/presentation/profile/bloc/user_cubit.dart';
import 'package:lecognition/presentation/profile/bloc/user_state.dart';
import 'package:lecognition/presentation/tree/pages/tree.dart';
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
                              _sectionWellcome(
                                context,
                                userState.user.username!.toUpperCase(),
                                userState.user.avatar!,
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
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Tanamanku',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          print('push page');
                                          AppNavigator.push(
                                            context,
                                            TreesScreen(),
                                          );
                                        },
                                        child: Text(
                                          'Lihat Semua',
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  // SizedBox(height: 5),
                                  _sectionTanamanku(context),
                                  SizedBox(height: 15),
                                  Text(
                                    'Daftar Penyakit',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  if (diseaseState is DiseasesFailureLoad ||
                                      bookmarkState
                                          is BookmarkedDiseasesFailureLoad ||
                                      userState is UserFailureLoad)
                                    Container(
                                      child: Center(
                                        child: Text(
                                          diseaseState is DiseasesFailureLoad
                                              ? diseaseState.errorMessage
                                              : (bookmarkState
                                                      is BookmarkedDiseasesFailureLoad
                                                  ? bookmarkState.errorMessage
                                                  : userState is UserFailureLoad
                                                      ? userState.errorMessage
                                                      : 'Terjadi kesalahan'),
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .error,
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
                                              top: 15.0,
                                              bottom: 10,
                                            ),
                                            child: DiseaseCard(
                                              disease: disease,
                                            ),
                                          ),
                                          Divider(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSecondary
                                                .withOpacity(0.5),
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
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget _sectionTanamanku(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            _cardTanamanku(
              context,
              'assets/images/mg.jpeg',
              'Tanaman 1',
              'Sehat',
              'Tanaman ini sehat',
            ),
            SizedBox(width: 15),
            _cardTanamanku(
              context,
              'assets/images/mg2.jpeg',
              'Tanaman 2',
              'Sakit',
              'Tanaman ini tidak sehat',
            ),
            SizedBox(width: 15),
            _cardTanamanku(
              context,
              'assets/images/mg3.jpeg',
              'Tanaman 3',
              'Perlu Perawatan',
              'Tanaman berada di lahan 10',
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardTanamanku(BuildContext context, String image, String namaTanaman,
      String statusTanaman, String deskripsi) {
    return InkWell(
      onTap: () {
        print('push page tanaman');
      },
      child: Container(
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width * 0.85,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(7),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(1, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                ),
              ),
              margin: EdgeInsets.only(right: 10),
              width: MediaQuery.of(context).size.width * 0.25,
              height: MediaQuery.of(context).size.width * 0.25,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.width * 0.25,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    namaTanaman,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Status: ${statusTanaman}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    deskripsi,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _actionButton(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => TabsScreen(index: 1),
            ),
          );
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 75,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon(
              //   Icons.camera_alt_outlined,
              //   size: 50,
              // ),
              // SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
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
    );
  }

  Widget _sectionWellcome(BuildContext context, String username, int avatar) {
    return Container(
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
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.white,
                    ),
              ),
              TextSpan(
                text: username,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
              )
            ],
          )),
          _showAvatar(context, avatar),
        ],
      ),
    );
  }

  Widget _showAvatar(BuildContext context, int idAvatar) {
    return Image(
      image: AssetImage('assets/avatars/Avatar_$idAvatar.png'),
      width: MediaQuery.of(context).size.width * 0.45,
      alignment: Alignment.bottomLeft,
    );
  }
}
