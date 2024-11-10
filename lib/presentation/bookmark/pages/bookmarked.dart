import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lecognition/common/widgets/appbar.dart';
import 'package:lecognition/presentation/bookmark/bloc/bookmark_cubit.dart';
import 'package:lecognition/presentation/bookmark/bloc/bookmark_state.dart';
import 'package:lecognition/widgets/bookmarkedCard.dart';

class BookmarkedScreen extends StatelessWidget {
  const BookmarkedScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookmarkCubit()..getAllBookmarkedDiseases(),
      child: BlocBuilder<BookmarkCubit, BookmarkState>(
        builder: (context, state) {
          if (state is BookmarkedDiseasesLoading) {
            return Scaffold(
              appBar: AppBarWidget(title: 'Penyakit Favorit'),
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state is BookmarkedDiseasesFailureLoad) {
            return Scaffold(
              appBar: AppBarWidget(title: 'Penyakit Favorit'),
              body: Center(
                child: Text(state.errorMessage),
              ),
            );
          }
          if (state is BookmarkedDiseasesLoaded) {
            final diseases = state.bookmarkedDiseases;
            if (diseases.isEmpty) {
              return Scaffold(
                appBar: AppBarWidget(title: 'Penyakit Favorit'),
                body: Text('Tidak ada penyakit favorit'),
              );
            }
            return Scaffold(
              appBar: AppBarWidget(title: 'Penyakit Favorit'),
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
