import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lecognition/domain/bookmark/usecases/get_bookmarked_diseases.dart';
import 'package:lecognition/presentation/bookmark/bloc/bookmark_state.dart';
import 'package:lecognition/service_locator.dart';

class BookmarkCubit extends Cubit<BookmarkState> {
  BookmarkCubit() : super(BookmarkedDiseasesLoading());

  void getAllBookmarkedDiseases() async {
    final returnedData = await sl<GetBookmarkedDiseasesUseCase>().call();
    print(returnedData);
    returnedData.fold(
      (error) => emit(BookmarkedDiseasesFailureLoad(errorMessage: error.toString())),
      (bookmarkedDiseases) => emit(BookmarkedDiseasesLoaded(bookmarkedDiseases: bookmarkedDiseases)),
    );
  }
}
