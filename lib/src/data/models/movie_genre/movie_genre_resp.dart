import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:xefi/src/data/mapper/entity_convertor.dart';
import 'package:xefi/src/domain/entities/export_entities.dart';

part 'movie_genre_resp.g.dart';

@JsonSerializable()
class MovieGenreResp extends Equatable
    with EntityConvertor<MovieGenreResp, MovieGenreEntity> {
  MovieGenreResp({
    this.modified,
    this.id,
    this.name,
    this.slug,
    this.originName,
    this.type,
    this.posterUrl,
    this.thumbUrl,
    this.subDocQuyen,
    this.chieuRap,
    this.time,
    this.episodeCurrent,
    this.quality,
    this.lang,
    this.year,
    this.category,
    this.country,
  });

  final Modified? modified;
  @JsonKey(name: '_id')
  final String? id;
  final String? name;
  final String? slug;
  @JsonKey(name: 'origin_name')
  final String? originName;
  final String? type;
  @JsonKey(name: 'poster_url')
  final String? posterUrl;
  @JsonKey(name: 'thumb_url')
  final String? thumbUrl;
  @JsonKey(name: 'sub_docquyen')
  final bool? subDocQuyen;
  @JsonKey(name: 'chieurap')
  final bool? chieuRap;
  final String? time;
  @JsonKey(name: 'episode_current')
  final String? episodeCurrent;
  final String? quality;
  final String? lang;
  final int? year;
  final List<Category>? category;
  final List<Country>? country;

  factory MovieGenreResp.fromJson(Map<String, dynamic> json) =>
      _$MovieGenreRespFromJson(json);

  Map<String, dynamic> toJson() => _$MovieGenreRespToJson(this);

  @override
  List<Object?> get props => [
        modified,
        id,
        name,
        slug,
        originName,
        type,
        posterUrl,
        thumbUrl,
        subDocQuyen,
        chieuRap,
        time,
        episodeCurrent,
        quality,
        lang,
        year,
        category,
        country,
      ];

  @override
  MovieGenreEntity toEntity() => MovieGenreEntity(
        modified: modified,
        id: id,
        name: name,
        slug: slug,
        originName: originName,
        type: type,
        posterUrl: posterUrl,
        thumbUrl: thumbUrl,
        subDocQuyen: subDocQuyen,
        chieuRap: chieuRap,
        time: time,
        episodeCurrent: episodeCurrent,
        quality: quality,
        lang: lang,
        year: year,
        category: category,
        country: country,
      );
}
