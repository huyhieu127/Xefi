import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:xefi/src/domain/entities/movie_detail/movie_detail_data_entity.dart';
import 'package:xefi/src/domain/usecases/network/movie/movie_usecases.dart';

part 'get_detail_state.dart';

class GetDetailCubit extends Cubit<GetDetailState> {
  final MovieUseCases _movieUseCase;

  GetDetailCubit(this._movieUseCase) : super(GetDetailInitial());

  final int _page = 1;

  // For pagination
  bool hasReachedMax = false;

  Future<void> getDetail({required String slugName}) async {
    try {
      emit(const GetDetailLoading());
      final result = await _movieUseCase.getDetail(slugName: slugName);
      result.fold(
        (error) => emit(GetDetailError(message: error.message)),
        (data) => emit(GetDetailSuccess(movieDetailData: data)),
      );
    } catch (ex) {
      emit(GetDetailError(message: ex.runtimeType.toString()));
      rethrow;
    }
  }

// Future<void> GetDetail() async {
//   try {
//     if (hasReachedMax) return;
//     if (state is! GetDetailSuccess) {
//       emit(const GetDetailLoading());
//     }
//     final result = await _movieUseCase.GetDetail(page: _page);
//
//     result.fold(
//       (error) => emit(GetDetailError(message: error.message)),
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
//         emit(GetDetailSuccess(movies: List.of(_newestList)));
//       },
//     );
//   } catch (_) {
//     rethrow;
//   }
// }
}
