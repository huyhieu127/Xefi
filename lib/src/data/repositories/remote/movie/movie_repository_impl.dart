import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:xefi/src/core/network/exception/network_exception.dart';
import 'package:xefi/src/core/utils/enums/movie_genre.dart';
import 'package:xefi/src/data/data_sources/remote/movie/movie_datasource.dart';
import 'package:xefi/src/domain/entities/export_entities.dart';
import 'package:xefi/src/domain/entities/movie_detail/movie_detail_data_entity.dart';
import 'package:xefi/src/domain/repositories/remote/movie/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieDatasource _movieDatasource;

  MovieRepositoryImpl(this._movieDatasource);

  @override
  Future<Either<NetworkException, List<MovieNewestEntity>>> getNewest({
    required int page,
  }) async {
    try {
      final result = await _movieDatasource.getNewest(page: page);
      final movies = result.map((resp) => resp.toEntity()).toList();
      return Right(movies);
    } on DioException catch (e) {
      return Left(NetworkException.fromDioError(e));
    }
  }

  @override
  Future<Either<NetworkException, MovieDetailDataEntity?>> getDetail({
    required String slugName,
  }) async {
    try {
      final result = await _movieDatasource.getDetail(slugName: slugName);
      final entity = result?.toEntity();
      return Right(entity);
    } on DioException catch (e) {
      return Left(NetworkException.fromDioError(e));
    }
  }

  @override
  Future<Either<NetworkException, MovieGenreDataEntity?>> getMovieGenre({
    required MovieGenre movieGenre,
    required int page,
    int limit = 10,
  }) async {
    try {
      final result = await _movieDatasource.getMovieGenre(
        movieGenre: movieGenre,
        page: page,
        limit: limit,
      );
      final data = result?.toEntity();
      return Right(data);
    } on DioException catch (e) {
      return Left(NetworkException.fromDioError(e));
    }
  }

  @override
  Future<Either<NetworkException, MovieGenreDataEntity?>> getSearch({
    required String keyword,
    int limit = 10,
    CancelToken? cancelToken,
  }) async {
    try {
      final result = await _movieDatasource.getSearch(
        keyword: keyword,
        limit: limit,
        cancelToken: cancelToken,
      );
      final data = result?.toEntity();
      return Right(data);
    } on DioException catch (e) {
      return Left(NetworkException.fromDioError(e));
    }
  }
}
