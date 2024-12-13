import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lecognition/common/helper/message/display_message.dart';
import 'package:lecognition/widgets/appbar.dart';
import 'package:lecognition/core/configs/assets/app_images.dart';
import 'package:lecognition/domain/disease/entities/disease.dart';
import 'package:lecognition/presentation/bookmark/bloc/bookmark_cubit.dart';
import 'package:lecognition/presentation/bookmark/bloc/bookmark_state.dart';

class DiseaseScreen extends StatefulWidget {
  DiseaseScreen({
    super.key,
    required this.disease,
  });

  final DiseaseEntity disease;

  @override
  State<DiseaseScreen> createState() => _DiseaseScreenState();
}

class _DiseaseScreenState extends State<DiseaseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: widget.disease.name.toString(),
      ),
      body: BlocProvider(
        create: (context) => BookmarkCubit(),
        child: BlocConsumer<BookmarkCubit, BookmarkState>(
          listener: (context, state) {
            if (state is BookmarkActionFailure) {
              DisplayMessage.errorMessage(context, state.errorMessage);
            } else if (state is BookmarkActionSuccess) {
              DisplayMessage.errorMessage(
                context,
                state.isBookmarked
                    ? 'Berhasil ditambahkan ke bookmark'
                    : 'Berhasil dihapus dari bookmark',
              );
            }
          },
          builder: (context, state) {
            bool isBookmarked = widget.disease.isBookmarked ?? false;
            int? idBookmarked = widget.disease.idBookmarked;

            if (state is BookmarkActionSuccess) {
              isBookmarked = state.isBookmarked;
              idBookmarked = state.idBookmarked;
            }

            return ListView(
              children: [
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return _showImage(context);
                      },
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 3.5,
                    child: Hero(
                      tag: "photo_${widget.disease.id}",
                      child: Container(
                        decoration: BoxDecoration(
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
                    ),
                  ),
                ),
                // Informasi Penyakit
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.disease.name.toString(),
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.disease.desc.toString(),
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      if (isBookmarked) {
                        context.read<BookmarkCubit>().unbookmarkDisease(idBookmarked!);
                      } else {
                        context.read<BookmarkCubit>().bookmarkDisease(widget.disease.id!);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isBookmarked
                          ? Colors.red
                          : Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      isBookmarked ? 'Batal Simpan' : 'Simpan Penyakit',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                // Level Bahaya
                _descriptionCard(
                    title: 'Level Bahaya',
                    subtitles: [widget.disease.detail!.severity],
                    context: context
                ),
                Divider(
                  color: Theme.of(context).colorScheme.onSecondary.withOpacity(0.5),
                  thickness: 1.0,
                  height: 1.0,
                ),
                // Pengobatan
                _descriptionCard(
                    title: 'Pengobatan',
                    subtitles: widget.disease.detail!.treatment,
                    context: context
                ),
                Divider(
                  color: Theme.of(context).colorScheme.onSecondary.withOpacity(0.5),
                  thickness: 1.0,
                  height: 1.0,
                ),
                // Pencegahan
                _descriptionCard(
                    title: 'Pencegahan',
                    subtitles: widget.disease.detail!.prevention,
                    context: context
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _descriptionCard({
    required String title,
    required List<String> subtitles,
    required BuildContext context,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5, left: 10, right: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSecondaryContainer,
            ),
          ),
          const SizedBox(height: 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: subtitles.length > 1
              ? subtitles
                .map((subtitle) => Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    '- $subtitle',
                    style: const TextStyle(fontSize: 14),
                  ),
                )).toList()
              : [
                  Text(
                    subtitles.first,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
          ),
        ],
      ),
    );
  }

  Widget _showImage(BuildContext context) {
    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 2.2,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              AppImages.basePathDisease + widget.disease.id.toString() + ".jpg",
            ),
            onError: (exception, stackTrace) {
              print('Error loading image: $exception');
            },
          ),
        ),
      ),
    );
  }
}
