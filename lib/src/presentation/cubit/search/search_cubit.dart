import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:xefi/src/core/network/config/api_constants.dart';
import 'package:xefi/src/domain/entities/export_entities.dart';
import 'package:xefi/src/domain/usecases/movie/movie_usecases.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final MovieUseCases _movieUseCase;

  SearchCubit(this._movieUseCase) : super(SearchInitial());

  static const int _limit = ApiConstants.limit;
  String keyword = "";
  CancelToken? cancelToken;

  Future<void> getSearch({
    required String keyword,
  }) async {
    try {
      this.keyword = keyword;
      if (this.keyword.isEmpty) {
        cancelToken?.cancel();
        emit(const SearchSuccess(movies: [], domainImage: ""));
        return;
      }
      emit(const SearchLoading());
      final result = await _movieUseCase.getSearch(
        keyword: keyword,
        limit: _limit,
        cancelToken: cancelToken,
      );
      result.fold(
        (error) {
          emit(SearchError(message: error.message));
        },
        (movieGenreDataEntity) {
          final movies = movieGenreDataEntity?.movies?.toList() ?? [];
          final domainImage = movieGenreDataEntity?.appDomainCdnImage ?? "";
          if (this.keyword.isEmpty) return;
          emit(SearchSuccess(
            movies: movies,
            domainImage: domainImage,
          ));
        },
      );
    } catch (_) {
      rethrow;
    }
  }
}
