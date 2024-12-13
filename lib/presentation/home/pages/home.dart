import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lecognition/widgets/tabs.dart';
import 'package:lecognition/domain/bookmark/entities/bookmark.dart';
import 'package:lecognition/domain/disease/entities/disease.dart';
import 'package:lecognition/domain/disease/entities/disease_detail.dart';
import 'package:lecognition/domain/tree/entities/tree.dart';
import 'package:lecognition/presentation/bookmark/bloc/bookmark_cubit.dart';
import 'package:lecognition/presentation/bookmark/bloc/bookmark_state.dart';
import 'package:lecognition/presentation/home/bloc/disease_cubit.dart';
import 'package:lecognition/presentation/home/bloc/disease_state.dart';
import 'package:lecognition/presentation/profile/bloc/user_cubit.dart';
import 'package:lecognition/presentation/profile/bloc/user_state.dart';
import 'package:lecognition/presentation/tree/bloc/tree_cubit.dart';
import 'package:lecognition/presentation/tree/bloc/tree_state.dart';
import 'package:lecognition/presentation/tree/pages/tree.dart';
import 'package:lecognition/presentation/tree/pages/trees.dart';
import 'package:lecognition/widgets/disease_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/constant/api_urls.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static List<DiseaseEntity> localDiseasesData = [];

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

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
      disease.isBookmarked = bookmarkedDiseases.any((bookmark) => bookmark.disease?.id == disease.id);
      if (disease.isBookmarked == true) {
        disease.idBookmarked = bookmarkedDiseases.firstWhere((bookmark) => bookmark.disease?.id == disease.id).id;
      }
      HomeScreen.localDiseasesData.add(disease);
      print(HomeScreen.localDiseasesData);
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
        BlocProvider<TreeCubit>(
          create: (context) => TreeCubit()..getAllTrees(),
        ),
      ],
      child: BlocBuilder<UserCubit, UserState>(
        builder: (context, userState) {
          return BlocBuilder<DiseaseCubit, DiseaseState>(
            builder: (context, diseaseState) {
              return BlocBuilder<BookmarkCubit, BookmarkState>(
                builder: (context, bookmarkState) {
                  return BlocBuilder<TreeCubit, TreeState>(
                    builder: (context, treeState) {
                      List<BookmarkEntity> bookmarkedDiseases = [];
                      if (bookmarkState is BookmarkedDiseasesLoaded && diseaseState is DiseasesLoaded &&
                          userState is UserLoaded && treeState is TreesLoaded) {
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
                            userState is UserLoading || treeState is TreeLoading,
                        child: SingleChildScrollView(
                          child: Container(
                            child: Column(
                              children: [
                                if (userState is UserLoaded)
                                  _sectionWellcome(
                                    context,
                                    userState.user.username!,
                                    userState.user.avatar!,
                                  ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(20),
                                    ),
                                    color: Theme.of(context).colorScheme.surface,
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
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Daftar Tanaman',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              print('push page');
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) {
                                                  return TreesScreen();
                                                }),
                                              ).then((_) {
                                                BlocProvider.of<TreeCubit>(context).getAllTrees();
                                              });
                                            },
                                            child: Text(
                                              'Lihat Semua',
                                              style: TextStyle(
                                                color: Theme.of(context).colorScheme.onPrimaryContainer,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      if (treeState is TreesLoaded)
                                        _sectionTanamanku(
                                          context,
                                          treeState.trees,
                                        ),
                                      SizedBox(height: 15),
                                      Text(
                                        'Daftar Penyakit',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      if (diseaseState is DiseasesFailureLoad || bookmarkState is BookmarkedDiseasesFailureLoad ||
                                          userState is UserFailureLoad || treeState is TreeFailureLoad)
                                        Container(
                                          child: Center(
                                            child: Text(
                                              diseaseState
                                              is DiseasesFailureLoad ? diseaseState.errorMessage : (bookmarkState
                                              is BookmarkedDiseasesFailureLoad ? bookmarkState.errorMessage: userState
                                              is UserFailureLoad ? userState.errorMessage : 'Terjadi kesalahan'),
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
                                                  top: 15.0,
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
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget _sectionTanamanku(
    BuildContext context,
    List<TreeEntityWithoutForeign> trees,
  ) {
    print(trees);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: trees.isEmpty
          ? [
            Text(
              'Tidak ada tanaman',
              style: TextStyle(fontSize: 16,),
            ),
            ]
          : List.generate(
            trees.length > 3 ? 3 : trees.length,
                (i) => _cardTanamanku(
              context,
              trees[i],
              i,
            ),
          ),
        ),
      ),
    );
  }

  Widget _cardTanamanku(
    BuildContext context,
    TreeEntityWithoutForeign tree,
    int index,
  ) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) {
            return TreeDetailScreen(tree: tree);
          }),
        ).then((_) {
          BlocProvider.of<TreeCubit>(context).getAllTrees();
        });
      },
      child: _buildTreeCard(context, tree),
    );
  }

  Widget _buildTreeCard(
    BuildContext context,
    TreeEntityWithoutForeign tree,
  ) {
    print("URL IMAGE: ${tree.image}");
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(right: 15),
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
            height: 75,
            width: 75,
            decoration: BoxDecoration(
              color: Colors.grey,
              image: DecorationImage(
                image: Image.network(ApiUrls.baseUrlWithoutApi + tree.image!.substring(1),).image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tree.name ?? 'Nama tidak tersedia',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '${tree.lastDiagnosis == null ? 'Belum pernah didiagnosis' : tree.lastDiagnosis! == 1 ? 'Tanaman sehat ^^' : 'Tanaman sakit :('}',
                  ),
                ],
              ),
            ),
          ),
          Icon(Icons.arrow_forward_ios, size: 16),
        ],
      ),
    );
  }

  Widget _actionButton(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(vertical: 15),
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
          height: 40,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(45),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Diagnosis Sekarang',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
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
                    style: TextStyle(color: Colors.white, fontSize: 25)
                ),
                TextSpan(
                  text: username,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 23),
                )
              ],
            )
          ),
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
