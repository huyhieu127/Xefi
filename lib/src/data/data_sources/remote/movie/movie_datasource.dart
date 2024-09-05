import 'package:xefi/src/core/utils/enums/movie_genre.dart';
import 'package:xefi/src/data/models/export_models.dart';

abstract class MovieDatasource {
  //REMOTE
  Future<List<MovieNewestResp>> getNewest({required int page});

  Future<MovieDetailDataResp?> getDetail({required String slugName});

  Future<MovieGenreDataResp?> getMovieGenre({
    required MovieGenre movieGenre,
    required int page,
    int limit = 10,
  });

  Future<List<MovieNewestResp>> getSearch({
    required String keyword,
    int limit = 10,
  });
}
