import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:xefi/src/data/mapper/entity_convertor.dart';
import 'package:xefi/src/domain/entities/export_entities.dart';

part 'movie_detail_resp.g.dart';

@JsonSerializable()
class MovieDetailResp extends Equatable
    with EntityConvertor<MovieDetailResp, MovieDetailEntity> {
  const MovieDetailResp({
    this.created,
    this.modified,
    this.id, //_id
    this.name,
    this.slug,
    this.originName, //origin_name
    this.content,
    this.type,
    this.status,
    this.posterUrl, //poster_url
    this.thumbUrl, //thumb_url
    this.isCopyright, //is_copyright
    this.subDocQuyen, //sub_docquyen
    this.chieuRap,
    this.trailerUrl, //trailer_url
    this.time,
    this.episodeCurrent, //episode_current
    this.episodeTotal, //episode_total
    this.quality,
    this.lang,
    this.notify,
    this.showTimes,
    this.year,
    this.view,
    this.actor,
    this.director,
    this.category,
    this.country,
  });

  final Created? created;
  final Modified? modified;
  @JsonKey(name: '_id')
  final String? id;
  final String? name;
  final String? slug;
  @JsonKey(name: 'origin_name')
  final String? originName;
  final String? content;
  final String? type;
  final String? status;
  @JsonKey(name: 'poster_url')
  final String? posterUrl;
  @JsonKey(name: 'thumb_url')
  final String? thumbUrl;
  @JsonKey(name: 'is_copyright')
  final bool? isCopyright;
  @JsonKey(name: 'sub_docquyen')
  final bool? subDocQuyen;
  @JsonKey(name: 'chieurap')
  final bool? chieuRap;
  @JsonKey(name: 'trailer_url')
  final String? trailerUrl;
  final String? time;
  @JsonKey(name: 'episode_current')
  final String? episodeCurrent;
  @JsonKey(name: 'episode_total')
  final String? episodeTotal;
  final String? quality;
  final String? lang;
  final String? notify;
  @JsonKey(name: 'showtimes')
  final String? showTimes;
  final int? year;
  final int? view;
  final List<String>? actor;
  final List<String>? director;
  final List<Category>? category;
  final List<Country>? country;

  @override
  List<Object?> get props => [
        created,
        modified,
        id,
        name,
        slug,
        originName,
        content,
        type,
        status,
        posterUrl,
        thumbUrl,
        isCopyright,
        subDocQuyen,
        chieuRap,
        trailerUrl,
        time,
        episodeCurrent,
        episodeTotal,
        quality,
        lang,
        notify,
        showTimes,
        year,
        view,
        actor,
        director,
        category,
        country,
      ];

  factory MovieDetailResp.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailRespFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailRespToJson(this);

  @override
  MovieDetailEntity toEntity() => MovieDetailEntity(
        created: created,
        modified: modified,
        id: id,
        name: name,
        slug: slug,
        originName: originName,
        content: content,
        type: type,
        status: status,
        posterUrl: posterUrl,
        thumbUrl: thumbUrl,
        isCopyright: isCopyright,
        subDocQuyen: subDocQuyen,
        chieuRap: chieuRap,
        trailerUrl: trailerUrl,
        time: time,
        episodeCurrent: episodeCurrent,
        episodeTotal: episodeTotal,
        quality: quality,
        lang: lang,
        notify: notify,
        showTimes: showTimes,
        year: year,
        view: view,
        actor: actor,
        director: director,
        category: category,
        country: country,
      );
}
