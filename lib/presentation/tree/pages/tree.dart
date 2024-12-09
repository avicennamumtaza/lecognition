import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lecognition/common/widgets/appbar.dart';
import 'package:lecognition/presentation/tree/bloc/tree_cubit.dart';
import 'package:lecognition/presentation/tree/bloc/tree_state.dart';
import 'package:lecognition/presentation/tree/pages/add_tree.dart';
import 'package:lecognition/widgets/tree_card.dart';

class TreesScreen extends StatelessWidget {
  const TreesScreen({super.key});

  // void linkDiseaseDetails(List<BookmarkEntity> bookmarkedDiseases) {
  //   print(bookmarkedDiseases);
  //   for (var bookmarkedDisease in bookmarkedDiseases) {
  //     print(bookmarkedDisease);
  //     print(bookmarkedDisease.disease);
  //     print(bookmarkedDisease.disease?.detail);
  //     bookmarkedDisease.disease?.detail = diseaseDetails.firstWhere(
  //       (detail) => detail.id == bookmarkedDisease.disease?.id,
  //       orElse: null,
  //     );
  //     bookmarkedDisease.disease?.idBookmarked = bookmarkedDisease.id;
  //     bookmarkedDisease.disease?.isBookmarked = true;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TreeCubit()..getAllTrees(),
      child: BlocBuilder<TreeCubit, TreeState>(
        builder: (context, state) {
          if (state is TreeLoading) {
            return Scaffold(
              appBar: AppBarWidget(title: 'Daftar Tanaman'),
              body: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state is TreeFailureLoad) {
            return Scaffold(
              appBar: AppBarWidget(title: 'Daftar Tanaman'),
              body: Center(
                child: Text(state.errorMessage),
              ),
            );
          }
          if (state is TreeLoaded) {
            final trees = state.trees;
            if (trees.isEmpty) {
              return Scaffold(
                appBar: AppBarWidget(title: 'Daftar Tanaman'),
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          'Kamu belum menambahkan tanaman apapun :(',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // ElevatedButton(onPressed: () {}, child: child),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddTreeScreen(),
                            ),
                          ).then((value) {
                            if (value != null) {
                              BlocProvider.of<TreeCubit>(context).getAllTrees();
                            }
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimary
                                    .withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Text(
                            'Tambah Tanaman',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return Scaffold(
              appBar: AppBarWidget(title: 'Daftar Tanaman'),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddTreeScreen(),
                          ),
                        ).then((_) {
                          BlocProvider.of<TreeCubit>(context).getAllTrees();
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimary
                                  .withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Text(
                          '+ Tanaman Baru',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Expanded(
                      child: GridView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // 2 cards per row
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                          childAspectRatio:
                              0.75, // Adjust card height-to-width ratio
                        ),
                        itemCount: trees.length,
                        itemBuilder: (BuildContext context, int index) {
                          final eachTree = trees[index];
                          return TreeCard(tree: eachTree);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
