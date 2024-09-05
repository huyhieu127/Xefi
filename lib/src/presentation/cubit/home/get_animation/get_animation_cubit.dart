import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:xefi/src/core/utils/enums/movie_genre.dart';
import 'package:xefi/src/domain/entities/export_entities.dart';
import 'package:xefi/src/domain/usecases/movie/movie_usecases.dart';

part 'get_animation_state.dart';

class GetAnimationCubit extends Cubit<GetAnimationState> {
  final MovieUseCases _movieUseCase;

  GetAnimationCubit(this._movieUseCase) : super(GetAnimationInitial());

  final int _page = 1;

  // For pagination
  bool hasReachedMax = false;

  Future<void> getAnimation() async {
    try {
      emit(const GetAnimationLoading());
      final result = await _movieUseCase.getMovieGenre(
        movieGenre: MovieGenre.animation,
        page: _page,
      );
      result.fold(
        (error) => emit(GetAnimationError(message: error.message)),
        (movieGenreDataEntity) => emit(
            GetAnimationSuccess(movieGenreDataEntity: movieGenreDataEntity)),
      );
    } catch (_) {
      rethrow;
    }
  }

// Future<void> GetAnimation() async {
//   try {
//     if (hasReachedMax) return;
//     if (state is! GetAnimationSuccess) {
//       emit(const GetAnimationLoading());
//     }
//     final result = await _movieUseCase.GetAnimation(page: _page);
//
//     result.fold(
//       (error) => emit(GetAnimationError(message: error.message)),
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
//         emit(GetAnimationSuccess(movies: List.of(_newestList)));
//       },
//     );
//   } catch (_) {
//     rethrow;
//   }
// }
}
