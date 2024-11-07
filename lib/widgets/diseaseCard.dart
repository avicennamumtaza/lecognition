import 'package:flutter/material.dart';
import 'package:lecognition/core/configs/assets/app_images.dart';
import 'package:lecognition/domain/disease/entities/disease.dart';
import 'package:lecognition/presentation/disease/pages/disease.dart';

class DiseaseCard extends StatefulWidget {
  const DiseaseCard({required this.disease, super.key});
  final DiseaseEntity disease;

  @override
  State<DiseaseCard> createState() => _DiseaseCardState();
}

class _DiseaseCardState extends State<DiseaseCard> {
  var isFavorite = false;

  @override
  Widget build(BuildContext context) {
    // final favoriteMeals = ref.watch(favoriteMealsProvider);
    onFavorite() {
      setState(() {
        isFavorite = !isFavorite;
      });
    }

    return Hero(
      tag: "photo_${widget.disease.id}",
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22.0),
        ),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DiseaseScreen(
                  disease: widget.disease,
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 4,
              // width: MediaQuery.of(context).size.width / - 20,
              child: Column(
                children: [
                  Expanded(
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18.0),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                AppImages.basePathDisease +
                                    widget.disease.id.toString() +
                                    ".jpg",
                              ),
                              onError: (exception, stackTrace) {
                                print('Error loading image: $exception');
                                print('Error loading image: $exception');
                              },
                            ),
                          ),
                        ),
                        Positioned(
                          top: 10.0,
                          right: 10.0,
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              width: 45.0,
                              height: 45.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).colorScheme.surface,
                              ),
                              child: IconButton(
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
                            ),
                          ),
                        ),
                        // Positioned(
                        //   bottom: -15.0,
                        //   left: 10.0,
                        //   child: Container(
                        //     width: 45.0,
                        //     height: 45.0,
                        //     decoration: BoxDecoration(
                        //       shape: BoxShape.circle,
                        //       color: this.disease.diseaseId != 0
                        //           ? Colors.green.shade800
                        //           : Colors.orange.shade800,
                        //     ),
                        //     child: Center(
                        //       child: Text(
                        //         this.disease.diseaseId != 0
                        //             ? "Healty"
                        //             : "Diseased",
                        //         style: const TextStyle(
                        //           fontSize: 8.0,
                        //           color: Colors.white,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                widget.disease.name.toString(),
                                style: TextStyle(
                                  fontSize: 17.0,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer,
                                ),
                              ),
                            ),
                            Text(
                              widget.disease.name.toString(),
                              style: TextStyle(
                                fontSize: 17.0,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withOpacity(0.5),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          widget.disease.desc.toString(),
                          style: TextStyle(
                            fontSize: 13.0,
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.align_horizontal_left_sharp,
                              size: 15.0,
                              color: Color.fromRGBO(255, 136, 0, 1),
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              widget.disease.name.toString(),
                              style: TextStyle(
                                fontSize: 13.0,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
                              ),
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
        ),
      ),
    );
  }
}
