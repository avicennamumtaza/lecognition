import 'package:flutter/material.dart';
import 'package:lecognition/common/widgets/appbar.dart';
import 'package:lecognition/data/dummy_disease.dart';
import 'package:lecognition/widgets/bookmarkedCard.dart';

class BookmarkedScreen extends StatefulWidget {
  const BookmarkedScreen({super.key});

  @override
  State<BookmarkedScreen> createState() => _BookmarkedScreenState();
}

class _BookmarkedScreenState extends State<BookmarkedScreen> {
  @override
  Widget build(BuildContext context) {
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
}