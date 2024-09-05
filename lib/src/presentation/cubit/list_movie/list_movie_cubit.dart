
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:xefi/src/core/utils/enums/movie_genre.dart';
import 'package:xefi/src/domain/entities/export_entities.dart';
import 'package:xefi/src/domain/usecases/movie/movie_usecases.dart';

part 'list_movie_state.dart';

class ListMovieCubit extends Cubit<ListMovieState> {
  final MovieUseCases _movieUseCase;

  ListMovieCubit(this._movieUseCase) : super(ListMovieInitial());

  final int _page = 1;
  int _limit = 20;

  // For pagination
  bool hasReachedMax = false;

  Future<void> getListMovie({required MovieGenre movieGenre}) async {
    try {
      emit(const ListMovieLoading());
      final result = await _movieUseCase.getMovieGenre(
        movieGenre: movieGenre,
        page: _page,
        limit: _limit,
      );
      result.fold(
        (error) => emit(ListMovieError(message: error.message)),
        (movieGenreDataEntity) => emit(
            ListMovieSuccess(movieGenreDataEntity: movieGenreDataEntity)),
      );
    } catch (_) {
      rethrow;
    }
  }

// Future<void> ListMovie() async {
//   try {
//     if (hasReachedMax) return;
//     if (state is! ListMovieSuccess) {
//       emit(const ListMovieLoading());
//     }
//     final result = await _movieUseCase.ListMovie(page: _page);
//
//     result.fold(
//       (error) => emit(ListMovieError(message: error.message)),
//       (success) {
//         // Increases the page number and adds the movies from the [success] response to the movie list.
//         // If a movie already exists in the movie list, it will not be added again.
//         // If the number of movies in the [success] response is less than 20, sets [hasReachedMax] to true.
//         // Emits a [GetPopularMoviesLoaded] state with the updated movie list.
//
//         _page++;
//         _newestList.addAll(
//             success.where((movie) => _newestList.contains(movie) == false));
//
//         /// Checks if the number of movies in the [success] response is less than 20.
//         /// If so, sets [hasReachedMax] to true.
//         if ((success.length) < ApiConstants.limit) {
//           hasReachedMax = true;
//         }
//
//         emit(ListMovieSuccess(movies: List.of(_newestList)));
//       },
//     );
//   } catch (_) {
//     rethrow;
//   }
// }
}
