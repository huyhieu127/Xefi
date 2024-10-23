import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:xefi/src/core/network/exception/network_exception.dart';
import 'package:xefi/src/core/utils/enums/movie_genre.dart';
import 'package:xefi/src/domain/entities/export_entities.dart';
import 'package:xefi/src/domain/entities/movie_detail/movie_detail_data_entity.dart';

abstract class MovieRepository {
  //REMOTE
  Future<Either<NetworkException, List<MovieNewestEntity>>> getNewest(
      {required int page});

  Future<Either<NetworkException, MovieDetailDataEntity?>> getDetail(
      {required String slugName});

  Future<Either<NetworkException, MovieGenreDataEntity?>> getMovieGenre({
    required MovieGenre movieGenre,
    required int page,
    int limit = 10,
  });

  Future<Either<NetworkException, MovieGenreDataEntity?>> getSearch({
    required String keyword,
    int limit = 10,
    CancelToken? cancelToken,
  });
}
