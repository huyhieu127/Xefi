import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:xefi/src/core/utils/enums/movie_genre.dart';
import 'package:xefi/src/domain/entities/export_entities.dart';
import 'package:xefi/src/domain/usecases/movie/movie_usecases.dart';

part 'get_movie_series_state.dart';

class GetMovieSeriesCubit extends Cubit<GetMovieSeriesState> {
  final MovieUseCases _movieUseCase;

  GetMovieSeriesCubit(this._movieUseCase) : super(GetMovieSeriesInitial());

  final int _page = 1;

  // For pagination
  bool hasReachedMax = false;

  Future<void> getMovieSeries() async {
    try {
      emit(const GetMovieSeriesLoading());
      final result = await _movieUseCase.getMovieGenre(
        movieGenre: MovieGenre.movieSeries,
        page: _page,
      );
      result.fold(
        (error) => emit(GetMovieSeriesError(message: error.message)),
        (movieGenreDataEntity) => emit(
            GetMovieSeriesSuccess(movieGenreDataEntity: movieGenreDataEntity)),
      );
    } catch (_) {
      rethrow;
    }
  }

// Future<void> GetMovieSeries() async {
//   try {
//     if (hasReachedMax) return;
//     if (state is! GetMovieSeriesSuccess) {
//       emit(const GetMovieSeriesLoading());
//     }
//     final result = await _movieUseCase.GetMovieSeries(page: _page);
//
//     result.fold(
//       (error) => emit(GetMovieSeriesError(message: error.message)),
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
//         emit(GetMovieSeriesSuccess(movies: List.of(_newestList)));
//       },
//     );
//   } catch (_) {
//     rethrow;
//   }
// }
}
