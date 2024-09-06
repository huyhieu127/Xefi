import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:xefi/src/core/network/config/api_constants.dart';
import 'package:xefi/src/core/utils/enums/movie_genre.dart';
import 'package:xefi/src/domain/entities/export_entities.dart';
import 'package:xefi/src/domain/usecases/movie/movie_usecases.dart';

part 'list_movie_state.dart';

class ListMovieCubit extends Cubit<ListMovieState> {
  final MovieUseCases _movieUseCase;

  ListMovieCubit(this._movieUseCase) : super(ListMovieInitial());

  static const int _limit = ApiConstants.limit;
  int _page = 1;
  final List<MovieGenreEntity> _movies = [];

  bool hasReachedMax = false;

  Future<void> getListMovie({
    required MovieGenre movieGenre,
    bool isRefresh = false,
  }) async {
    try {
      if (hasReachedMax) return;

      if (isRefresh) {
        _movies.clear();
        _page = 1;
      }

      if (_page == 1) {
        emit(const ListMovieLoading());
      }
      final result = await _movieUseCase.getMovieGenre(
        movieGenre: movieGenre,
        page: _page,
        limit: _limit,
      );
      result.fold(
        (error) {
          emit(ListMovieError(message: error.message));
        },
        (movieGenreDataEntity) {
          final movies = movieGenreDataEntity?.movies ?? [];
          final domainImage = movieGenreDataEntity?.appDomainCdnImage ?? "";
          if (movies.isNotEmpty) {
            _page++;
            if (movies.length < _limit) {
              hasReachedMax = true;
            }
            _movies.addAll(movies);
            emit(ListMovieSuccess(
              movies: _movies.toList(),
              domainImage: domainImage,
            ));
          }
        },
      );
    } catch (_) {
      rethrow;
    }
  }
}
