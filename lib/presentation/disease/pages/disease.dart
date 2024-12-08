import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lecognition/common/helper/message/display_message.dart';
import 'package:lecognition/common/widgets/appbar.dart';
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
              padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
              children: [
                // Detail konten penyakit...
                // Tombol Bookmark
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
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.only(bottom: 15),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 3.5,
                    child: Hero(
                      tag: "photo_${widget.disease.id}",
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
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
                // Deskripsi Penyakit
                _descriptionCard(
                    title: widget.disease.name!,
                    subtitles: [widget.disease.desc!],
                    context: context),
                // Level Bahaya
                _descriptionCard(
                    title: 'Level Bahaya',
                    subtitles: [widget.disease.detail!.severity],
                    context: context),
                // Pengobatan
                _descriptionCard(
                    title: 'Pengobatan',
                    subtitles: widget.disease.detail!.treatment,
                    context: context),
                // Pencegahan
                _descriptionCard(
                    title: 'Pencegahan',
                    subtitles: widget.disease.detail!.prevention,
                    context: context),
                ElevatedButton(
                  onPressed: () {
                    if (isBookmarked) {
                      context
                          .read<BookmarkCubit>()
                          .unbookmarkDisease(idBookmarked!);
                    } else {
                      context
                          .read<BookmarkCubit>()
                          .bookmarkDisease(widget.disease.id!);
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
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
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
              color: Theme.of(context).colorScheme.primary,
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
                        ))
                    .toList()
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
