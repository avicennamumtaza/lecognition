import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lecognition/common/helper/mapper/bookmark_mapper.dart';
import 'package:lecognition/data/bookmark/models/bookmark_disease_params.dart';
import 'package:lecognition/data/bookmark/models/unbookmark_disease_params.dart';
import 'package:lecognition/domain/bookmark/usecases/bookmark_disease.dart';
import 'package:lecognition/domain/bookmark/usecases/get_bookmarked_diseases.dart';
import 'package:lecognition/domain/bookmark/usecases/unbookmark_disease.dart';
import 'package:lecognition/presentation/bookmark/bloc/bookmark_state.dart';
import 'package:lecognition/service_locator.dart';

class BookmarkCubit extends Cubit<BookmarkState> {
  BookmarkCubit() : super(BookmarkedDiseasesLoading());

  void getAllBookmarkedDiseases() async {
    final returnedData = await sl<GetBookmarkedDiseasesUseCase>().call();
    print(returnedData);
    returnedData.fold(
      (error) => emit(
        BookmarkedDiseasesFailureLoad(
          errorMessage: error.toString(),
        ),
      ),
      (bookmarkedDiseases) => emit(
        BookmarkedDiseasesLoaded(
          bookmarkedDiseases: bookmarkedDiseases,
        ),
      ),
    );
  }

  // Tambah bookmark
  void bookmarkDisease(int diseaseId) async {
    emit(BookmarkActionLoading());
    final result = await sl<BookmarkDiseaseUseCase>().call(
      params: BookmarkDiseaseParams(
        diseaseId: diseaseId,
        date: 123456,
      ),
    );

    result.fold(
      (failure) => emit(
        BookmarkActionFailure(
          errorMessage: failure.toString(),
        ),
      ),
      (success) {
        final bookmarkData = BookmarkMapper.toEntityWithoutForeign(success);
        emit(
          BookmarkActionSuccess(
            isBookmarked: true,
            idBookmarked: bookmarkData.id,
          ),
        );
      },
    );
  }

  // Hapus bookmark
  void unbookmarkDisease(int bookmarkId) async {
    emit(BookmarkActionLoading());
    final result = await sl<UnbookmarkDiseaseUseCase>().call(
      params: UnbookmarkDiseaseParams(bookmarkId: bookmarkId),
    );

    result.fold(
      (failure) => emit(
        BookmarkActionFailure(
          errorMessage: failure.toString(),
        ),
      ),
      (_) => emit(
        BookmarkActionSuccess(isBookmarked: false, idBookmarked: null),
      ),
    );
  }
}
