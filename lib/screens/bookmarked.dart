import 'package:flutter/material.dart';
import 'package:lecognition/data/dummy_disease.dart';
import 'package:lecognition/widgets/bookmarkedCard.dart';

class BookmarkedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarked Diseases'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
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