import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:xefi/src/domain/entities/export_entities.dart';
import 'package:xefi/src/domain/usecases/movie/movie_usecases.dart';

part 'get_newest_state.dart';

class GetNewestCubit extends Cubit<GetNewestState> {
  final MovieUseCases _movieUseCase;

  GetNewestCubit(this._movieUseCase) : super(GetNewestInitial());

  final int _page = 1;

  // For pagination
  bool hasReachedMax = false;

  Future<void> getNewest() async {
    try {
      emit(const GetNewestLoading());
      final result = await _movieUseCase.getNewest(page: _page);
      result.fold(
        (error) => emit(GetNewestError(message: error.message)),
        (newestList) => emit(GetNewestSuccess(newestList: newestList)),
      );
    } catch (_) {
      rethrow;
    }
  }

// Future<void> getNewest() async {
//   try {
//     if (hasReachedMax) return;
//     if (state is! GetNewestSuccess) {
//       emit(const GetNewestLoading());
//     }
//     final result = await _movieUseCase.getNewest(page: _page);
//
//     result.fold(
//       (error) => emit(GetNewestError(message: error.message)),
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
//         emit(GetNewestSuccess(movies: List.of(_newestList)));
//       },
//     );
//   } catch (_) {
//     rethrow;
//   }
// }
}
