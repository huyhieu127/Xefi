import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:xefi/src/data/mapper/entity_convertor.dart';
import 'package:xefi/src/domain/entities/export_entities.dart';

part 'movie_newest_resp.g.dart';

@JsonSerializable()
class MovieNewestResp extends Equatable
    with EntityConvertor<MovieNewestResp, MovieNewestEntity> {
  final Modified? modified;
  final String? id;
  final String? name;
  final String? slug;
  @JsonKey(name: 'origin_name')
  final String? originName;
  @JsonKey(name: 'poster_url')
  final String? posterUrl;
  @JsonKey(name: 'thumb_url')
  final String? thumbUrl;
  final int? year;

  MovieNewestResp(this.modified, this.id, this.name, this.slug, this.originName,
      this.posterUrl, this.thumbUrl, this.year);

  factory MovieNewestResp.fromJson(Map<String, dynamic> json) =>
      _$MovieNewestRespFromJson(json);

  Map<String, dynamic> toJson() => _$MovieNewestRespToJson(this);

  @override
  List<Object?> get props =>
      [modified, id, name, slug, originName, posterUrl, thumbUrl, year];

  @override
  MovieNewestEntity toEntity() => MovieNewestEntity(
        modified: modified,
        id: id,
        name: name,
        slug: slug,
        originName: originName,
        posterUrl: posterUrl,
        thumbUrl: thumbUrl,
        year: year,
      );
}
