import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:xefi/src/data/mapper/entity_convertor.dart';
import 'package:xefi/src/domain/entities/movie_detail/movie_detail_data_entity.dart';

import '../export_models.dart';

part 'movie_detail_data_resp.g.dart';

@JsonSerializable()
class MovieDetailDataResp extends Equatable
    with EntityConvertor<MovieDetailDataResp, MovieDetailDataEntity> {
  final bool? status;
  final String? msg;
  final MovieDetailResp? movie;
  final List<ServerResp>? episodes;

  const MovieDetailDataResp({
    this.status,
    this.msg,
    this.movie,
    this.episodes,
  });

  @override
  List<Object?> get props => [
        status,
        msg,
        movie,
        episodes,
      ];
  factory MovieDetailDataResp.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailDataRespFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailDataRespToJson(this);

  @override
  MovieDetailDataEntity toEntity() => MovieDetailDataEntity(
        status: status,
        msg: msg,
        movie: movie?.toEntity(),
        servers: episodes?.map((resp) => resp.toEntity()).toList(),
      );
}
