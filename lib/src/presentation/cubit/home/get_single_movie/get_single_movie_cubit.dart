import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:xefi/src/core/utils/enums/movie_genre.dart';
import 'package:xefi/src/domain/entities/export_entities.dart';
import 'package:xefi/src/domain/usecases/movie/movie_usecases.dart';

part 'get_single_movie_state.dart';

class GetSingleMovieCubit extends Cubit<GetSingleMovieState> {
  final MovieUseCases _movieUseCase;

  GetSingleMovieCubit(this._movieUseCase) : super(GetSingleMovieInitial());

  final int _page = 1;

  // For pagination
  bool hasReachedMax = false;

  Future<void> getSingleMovie() async {
    try {
      emit(const GetSingleMovieLoading());
      final result = await _movieUseCase.getMovieGenre(
        movieGenre: MovieGenre.singleMovie,
        page: _page,
      );
      result.fold(
        (error) => emit(GetSingleMovieError(message: error.message)),
        (movieGenreDataEntity) => emit(
            GetSingleMovieSuccess(movieGenreDataEntity: movieGenreDataEntity)),
      );
    } catch (_) {
      rethrow;
    }
  }

// Future<void> GetSingleMovie() async {
//   try {
//     if (hasReachedMax) return;
//     if (state is! GetSingleMovieSuccess) {
//       emit(const GetSingleMovieLoading());
//     }
//     final result = await _movieUseCase.GetSingleMovie(page: _page);
//
//     result.fold(
//       (error) => emit(GetSingleMovieError(message: error.message)),
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
//         emit(GetSingleMovieSuccess(movies: List.of(_newestList)));
//       },
//     );
//   } catch (_) {
//     rethrow;
//   }
// }
}
