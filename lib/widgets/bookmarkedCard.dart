import 'package:flutter/material.dart';
import 'package:lecognition/models/disease.dart';

class BookmarkedCard extends StatefulWidget {
  final Disease disease;

  BookmarkedCard({
    super.key,
    required this.disease,
  });

  @override
  _BookmarkedCardState createState() => _BookmarkedCardState();
}

class _BookmarkedCardState extends State<BookmarkedCard> {
  var isFavorite = true;

  @override
  Widget build(BuildContext context) {
    onFavorite() {
      setState(() {
        isFavorite = !isFavorite;
      });
    }

    return Padding(
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: Container(
        height: MediaQuery.of(context).size.height / 2.5,
        width: MediaQuery.of(context).size.width,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          elevation: 3.0,
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height / 3.5,
                    width: MediaQuery.of(context).size.width,
                    child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        child: Image.network(
                            "https://halosehat.com/wp-content/uploads/2019/05/manfaat-daun-mangga-696x395.jpg")),
                  ),
                  Positioned(
                    top: 22.0,
                    right: 6.0,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0)),
                      child: Padding(
                        padding: EdgeInsets.all(1.0),
                        child: Row(
                          children: <Widget>[
                            IconButton(
                              icon: AnimatedSwitcher(
                                duration: const Duration(
                                  milliseconds: 300,
                                ),
                                transitionBuilder: (child, animation) {
                                  return ScaleTransition(
                                    scale: animation,
                                    child: child,
                                  );
                                },
                                child: Icon(
                                  isFavorite
                                      ? Icons.bookmark_outlined
                                      : Icons.bookmark_border_outlined,
                                  key: ValueKey(
                                    isFavorite,
                                  ),
                                ),
                              ),
                              onPressed: onFavorite,
                              // () {
                              // final wasAdded = ref
                              //     .read(favoriteMealsProvider.notifier)
                              //     .toggleMealFavoriteStatus(meal);
                              // ScaffoldMessenger.of(context).clearSnackBars();
                              // ScaffoldMessenger.of(context).showSnackBar(
                              //   SnackBar(
                              //     content: Text(wasAdded
                              //         ? "Meal added as a favorite"
                              //         : "Meal removed from favorite"),
                              //   ),
                              // );
                              // },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 7.0),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    "${widget.disease.diseaseName}",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              SizedBox(height: 7.0),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    "${widget.disease.description}",
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
            ],
          ),
        ),
      ),
    );
  }
}