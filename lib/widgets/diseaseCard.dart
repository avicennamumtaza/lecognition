import 'package:flutter/material.dart';
import 'package:lecognition/common/helper/message/display_message.dart';
import 'package:lecognition/core/configs/assets/app_images.dart';
import 'package:lecognition/data/bookmark/models/bookmark_disease_params.dart';
import 'package:lecognition/domain/bookmark/usecases/bookmark_disease.dart';
import 'package:lecognition/domain/disease/entities/disease.dart';
import 'package:lecognition/presentation/disease/pages/disease.dart';
import 'package:lecognition/service_locator.dart';

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
                        // Positioned(
                        //   top: 10.0,
                        //   right: 10.0,
                        //   child: InkWell(
                        //     onTap: () {},
                        //     child: Container(
                        //       width: 45.0,
                        //       height: 45.0,
                        //       decoration: BoxDecoration(
                        //         shape: BoxShape.circle,
                        //         color: Theme.of(context).colorScheme.surface,
                        //       ),
                        //       child: bookmarkIcon(context, widget.disease.id!),
                        //     ),
                        //   ),
                        // ),
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
                              widget.disease.detail!.severity,
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
                              widget.disease.detail!.prevention.length > 45
                                  ? '${widget.disease.detail!.prevention.substring(0, 45)}...'
                                  : widget.disease.detail!.prevention,
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

  Widget bookmarkIcon(BuildContext context, int diseaseId) {
    return IconButton(
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
          isFavorite ? Icons.bookmark_outlined : Icons.bookmark_border_outlined,
          key: ValueKey(
            isFavorite,
          ),
        ),
      ),
      onPressed: () async {
        try {
          final result = await sl<BookmarkDiseaseUseCase>().call(
            params: BookmarkDiseaseParams(
              diseaseId: diseaseId,
              date: DateTime.now(),
              // isFavorite: isFavorite,
            ),
          );
          result.fold(
            (failure) {
              DisplayMessage.errorMessage(context, failure.toString());
            },
            (success) {
              DisplayMessage.errorMessage(context, success.toString());
            },
          );
        } catch (error) {
          print(error);          
        }
      },
    );
  }
}
