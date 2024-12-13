import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lecognition/widgets/appbar.dart';
import 'package:lecognition/domain/bookmark/entities/bookmark.dart';
import 'package:lecognition/domain/disease/entities/disease_detail.dart';
import 'package:lecognition/presentation/bookmark/bloc/bookmark_cubit.dart';
import 'package:lecognition/presentation/bookmark/bloc/bookmark_state.dart';
import 'package:lecognition/widgets/bookmarked_card.dart';

class BookmarkedScreen extends StatelessWidget {
  const BookmarkedScreen({super.key});

  void linkDiseaseDetails(List<BookmarkEntity> bookmarkedDiseases) {
    print(bookmarkedDiseases);
    for (var bookmarkedDisease in bookmarkedDiseases) {
      print(bookmarkedDisease);
      print(bookmarkedDisease.disease);
      print(bookmarkedDisease.disease?.detail);
      bookmarkedDisease.disease?.detail = diseaseDetails.firstWhere(
        (detail) => detail.id == bookmarkedDisease.disease?.id,
        orElse: null,
      );
      bookmarkedDisease.disease?.idBookmarked = bookmarkedDisease.id;
      bookmarkedDisease.disease?.isBookmarked = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookmarkCubit()..getAllBookmarkedDiseases(),
      child: BlocBuilder<BookmarkCubit, BookmarkState>(
        builder: (context, state) {
          if (state is BookmarkedDiseasesLoading) {
            return Scaffold(
              appBar: AppBarWidget(title: 'Penyakit Tersimpan'),
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state is BookmarkedDiseasesFailureLoad) {
            return Scaffold(
              appBar: AppBarWidget(title: 'Penyakit Tersimpan'),
              body: Center(
                child: Text(state.errorMessage),
              ),
            );
          }
          if (state is BookmarkedDiseasesLoaded) {
            final diseases = state.bookmarkedDiseases;
            if (diseases.isEmpty) {
              return Scaffold(
                appBar: AppBarWidget(title: 'Penyakit Tersimpan'),
                body: Center(child: Text('Tidak ada penyakit tersimpan')),
              );
            }
            return Scaffold(
              appBar: AppBarWidget(title: 'Penyakit Tersimpan'),
              body: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 10.0,
                ),
                child: ListView(
                  children: <Widget>[
                    // SearchCard(),
                    SizedBox(height: 10.0),
                    ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: diseases.length,
                      itemBuilder: (BuildContext context, int index) {
                        linkDiseaseDetails(diseases);
                        final eachDisease = diseases[index];
                        return BookmarkedCard(disease: eachDisease);
                      },
                    ),
                    SizedBox(height: 10.0),
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
