import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:xefi/src/data/mapper/entity_convertor.dart';
import 'package:xefi/src/domain/entities/export_entities.dart';

import '../export_models.dart';

part 'movie_genre_data_resp.g.dart';

@JsonSerializable()
class MovieGenreDataResp extends Equatable
    with EntityConvertor<MovieGenreDataResp, MovieGenreDataEntity> {
  const MovieGenreDataResp({
    this.movies,
    this.params,
    this.typeList,
    this.appDomainFrontend,
    this.appDomainCdnImage,
  });

  @JsonKey(name: 'items')
  final List<MovieGenreResp>? movies;
  final Params? params;
  @JsonKey(name: 'type_list')
  final String? typeList;
  @JsonKey(name: 'APP_DOMAIN_FRONTEND')
  final String? appDomainFrontend;
  @JsonKey(name: 'APP_DOMAIN_CDN_IMAGE')
  final String? appDomainCdnImage;

  factory MovieGenreDataResp.fromJson(Map<String, dynamic> json) =>
      _$MovieGenreDataRespFromJson(json);

  Map<String, dynamic> toJson() => _$MovieGenreDataRespToJson(this);

  @override
  List<Object?> get props => [
        movies,
        params,
        typeList,
        appDomainFrontend,
        appDomainCdnImage,
      ];

  @override
  MovieGenreDataEntity toEntity() => MovieGenreDataEntity(
        movies: movies?.map((movieDetail) => movieDetail.toEntity()).toList(),
        params: params,
        typeList: typeList,
        appDomainFrontend: appDomainFrontend,
        appDomainCdnImage: appDomainCdnImage,
      );
}
