import 'package:xefi/src/core/network/config/url_constants.dart';
import 'package:xefi/src/core/network/dio/dio_client.dart';
import 'package:xefi/src/core/utils/enums/movie_genre.dart';
import 'package:xefi/src/data/data_sources/remote/movie/movie_datasource.dart';
import 'package:xefi/src/data/models/export_models.dart';

class MovieDatasourceImpl implements MovieDatasource {
  final DioClient _dioClient;

  const MovieDatasourceImpl(this._dioClient);

  @override
  Future<List<MovieNewestResp>> getNewest({required int page}) async {
    try {
      final response = await _dioClient
          .get(UrlConstants.newest, queryParameters: {'page': page});

      final baseResp = BaseResp.fromJson(response.data as Map<String, dynamic>);
      final listMovies = baseResp.items;
      return listMovies ?? List.empty();
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<MovieDetailDataResp?> getDetail({required String slugName}) async {
    try {
      final response = await _dioClient.get(
        UrlConstants.detail.replaceAll("{slug_movie}", slugName),
      );

      final data =
          MovieDetailDataResp.fromJson(response.data as Map<String, dynamic>);
      return data;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<MovieGenreDataResp?> getMovieGenre({
    required MovieGenre movieGenre,
    required int page,
    int limit = 10,
  }) async {
    try {
      final response = await _dioClient.get(
        UrlConstants.movieGenre.replaceAll("{movie_genre}", movieGenre.genre),
        queryParameters: {
          'page': page,
          'limit': limit,
        },
      );
      final baseResp = BaseResp.fromJson(response.data as Map<String, dynamic>);
      return baseResp.data;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<MovieNewestResp>> getSearch(
      {required String keyword, int limit = 10}) async {
    try {
      final response = await _dioClient
          .get(UrlConstants.newest, queryParameters: {'page': 1});

      final baseResp = BaseResp.fromJson(response.data as Map<String, dynamic>);
      final listMovies = baseResp.items;
      return listMovies ?? List.empty();
    } catch (_) {
      rethrow;
    }
  }
}
