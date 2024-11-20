import 'package:flutter/material.dart';
import 'package:lecognition/common/helper/mapper/bookmark_mapper.dart';
import 'package:lecognition/common/helper/message/display_message.dart';
import 'package:lecognition/common/helper/navigation/app_navigator.dart';
import 'package:lecognition/common/widgets/appbar.dart';
import 'package:lecognition/core/configs/assets/app_images.dart';
import 'package:lecognition/data/bookmark/models/bookmark_disease_params.dart';
import 'package:lecognition/data/bookmark/models/unbookmark_disease_params.dart';
import 'package:lecognition/domain/bookmark/usecases/bookmark_disease.dart';
import 'package:lecognition/domain/bookmark/usecases/unbookmark_disease.dart';
import 'package:lecognition/domain/disease/entities/disease.dart';
import 'package:lecognition/presentation/bookmark/pages/bookmarked.dart';
import 'package:lecognition/presentation/home/pages/home.dart';
import 'package:lecognition/service_locator.dart';

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
    print(widget.disease.isBookmarked);
    print(widget.disease.detail);
    print(widget.disease.detail?.treatment);
    return Scaffold(
      appBar: AppBarWidget(
        title: widget.disease.name.toString(),
      ),
      body: ListView(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
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
              title: widget.disease.name.toString(),
              subtitle: widget.disease.desc.toString(),
              context: context),
          // Pengobatan
          _descriptionCard(
              title: 'Pengobatan',
              subtitle: widget.disease.detail!.treatment.toString(),
              context: context),
          // Pencegahan
          _descriptionCard(
              title: 'Pencegahan',
              subtitle: widget.disease.detail!.prevention.toString(),
              context: context),
          // Level Bahaya
          _descriptionCard(
              title: 'Level Bahaya',
              subtitle: widget.disease.detail!.severity.toString(),
              context: context),
          // Tombol Bookmark
          ElevatedButton(
            onPressed: () async {
              print(widget.disease.isBookmarked!);
              if (widget.disease.isBookmarked != null &&
                  widget.disease.isBookmarked!) {
                try {
                  // print(widget.disease.idBookmarked!);
                  final result = await sl<UnbookmarkDiseaseUseCase>().call(
                    params: UnbookmarkDiseaseParams(
                        bookmarkId: widget.disease.idBookmarked!),
                  );
                  result.fold(
                    (failure) {
                      DisplayMessage.errorMessage(context, failure.toString());
                      print(failure);
                    },
                    (success) {
                      DisplayMessage.errorMessage(context, 'Berhasil dihapus');
                      // AppNavigator.push(
                      //   context,
                      //   const BookmarkedScreen(),
                      // );
                      print(success);
                      setState(() {
                        widget.disease.isBookmarked = false;
                        widget.disease.idBookmarked = null;
                      });
                    },
                  );
                  AppNavigator.pushReplacement(context, BookmarkedScreen());
                  // AppNavigator.pushAndRemove(context, BookmarkedScreen());
                } catch (error) {
                  DisplayMessage.errorMessage(context, error.toString());
                  print(error);
                }
              } else {
                try {
                  // print(widget.disease.idBookmarked!);
                  final result = await sl<BookmarkDiseaseUseCase>().call(
                    params: BookmarkDiseaseParams(
                      diseaseId: widget.disease.id!,
                      date: 123456,
                    ),
                  );
        
                  print("HTTP Response ${result}");
                  result.fold(
                    (failure) {
                      DisplayMessage.errorMessage(context, failure.toString());
                      print(failure);
                    },
                    (success) {
                      print('Success: ${success}');
                      final bookmarkData = BookmarkMapper.toEntityWithoutForeign(success);
                      print('Response data: ${bookmarkData}');
                      DisplayMessage.errorMessage(context, 'Berhasil disimpan');
                      print('Response data id: ${bookmarkData.id}');
                      setState(() {
                        widget.disease.isBookmarked = true;
                        widget.disease.idBookmarked = bookmarkData.id;
                      });
                      AppNavigator.pushReplacement(context, BookmarkedScreen());
                    },
                  );
                } catch (error) {
                  print(error);
                  DisplayMessage.errorMessage(context, error.toString());
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: widget.disease.isBookmarked!
                  ? Colors.red
                  : Theme.of(context).colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              widget.disease.isBookmarked!
                  ? 'Hapus Bookmark'
                  : 'Tambah Bookmark',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _descriptionCard({
    required String title,
    required String subtitle,
    required BuildContext context,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.topLeft,
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          style: TextStyle(
            fontSize: 17,
          ),
          subtitle,
        ),
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
