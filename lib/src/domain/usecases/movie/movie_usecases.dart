import 'package:dartz/dartz.dart';
import 'package:xefi/src/core/network/exception/network_exception.dart';
import 'package:xefi/src/core/utils/enums/movie_genre.dart';
import 'package:xefi/src/domain/entities/export_entities.dart';
import 'package:xefi/src/domain/entities/movie_detail/movie_detail_data_entity.dart';
import 'package:xefi/src/domain/repositories/movie/movie_repository.dart';

class MovieUseCases {
  final MovieRepository _movieRepository;

  MovieUseCases(this._movieRepository);

  Future<Either<NetworkException, List<MovieNewestEntity>>> getNewest({
    required int page,
  }) async {
    return _movieRepository.getNewest(page: page);
  }

  Future<Either<NetworkException, MovieGenreDataEntity?>> getMovieGenre({
    required MovieGenre movieGenre,
    required int page,
    int limit = 10,
  }) async {
    return _movieRepository.getMovieGenre(
      movieGenre: movieGenre,
      page: page,
      limit: limit,
    );
  }

  Future<Either<NetworkException, MovieDetailDataEntity?>> getDetail({
    required String slugName,
  }) async {
    return _movieRepository.getDetail(slugName: slugName);
  }
}
