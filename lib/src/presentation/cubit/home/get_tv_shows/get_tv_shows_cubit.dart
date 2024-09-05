import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:xefi/src/core/utils/enums/movie_genre.dart';
import 'package:xefi/src/domain/entities/export_entities.dart';
import 'package:xefi/src/domain/usecases/movie/movie_usecases.dart';

part 'get_tv_shows_state.dart';

class GetTvShowsCubit extends Cubit<GetTvShowsState> {
  final MovieUseCases _movieUseCase;

  GetTvShowsCubit(this._movieUseCase) : super(GetTvShowsInitial());

  final int _page = 1;

  // For pagination
  bool hasReachedMax = false;

  Future<void> getTvShows() async {
    try {
      emit(const GetTvShowsLoading());
      final result = await _movieUseCase.getMovieGenre(
        movieGenre: MovieGenre.tvShows,
        page: _page,
      );
      result.fold(
        (error) => emit(GetTvShowsError(message: error.message)),
        (movieGenreDataEntity) =>
            emit(GetTvShowsSuccess(movieGenreDataEntity: movieGenreDataEntity)),
      );
    } catch (_) {
      rethrow;
    }
  }

// Future<void> GetTvShows() async {
//   try {
//     if (hasReachedMax) return;
//     if (state is! GetTvShowsSuccess) {
//       emit(const GetTvShowsLoading());
//     }
//     final result = await _movieUseCase.GetTvShows(page: _page);
//
//     result.fold(
//       (error) => emit(GetTvShowsError(message: error.message)),
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
//         emit(GetTvShowsSuccess(movies: List.of(_newestList)));
//       },
//     );
//   } catch (_) {
//     rethrow;
//   }
// }
}
