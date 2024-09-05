// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_detail_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieDetailResp _$MovieDetailRespFromJson(Map<String, dynamic> json) =>
    MovieDetailResp(
      created: json['created'] == null
          ? null
          : Created.fromJson(json['created'] as Map<String, dynamic>),
      modified: json['modified'] == null
          ? null
          : Modified.fromJson(json['modified'] as Map<String, dynamic>),
      id: json['_id'] as String?,
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      originName: json['origin_name'] as String?,
      content: json['content'] as String?,
      type: json['type'] as String?,
      status: json['status'] as String?,
      posterUrl: json['poster_url'] as String?,
      thumbUrl: json['thumb_url'] as String?,
      isCopyright: json['is_copyright'] as bool?,
      subDocQuyen: json['sub_docquyen'] as bool?,
      chieuRap: json['chieurap'] as bool?,
      trailerUrl: json['trailer_url'] as String?,
      time: json['time'] as String?,
      episodeCurrent: json['episode_current'] as String?,
      episodeTotal: json['episode_total'] as String?,
      quality: json['quality'] as String?,
      lang: json['lang'] as String?,
      notify: json['notify'] as String?,
      showTimes: json['showtimes'] as String?,
      year: (json['year'] as num?)?.toInt(),
      view: (json['view'] as num?)?.toInt(),
      actor:
          (json['actor'] as List<dynamic>?)?.map((e) => e as String).toList(),
      director: (json['director'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      category: (json['category'] as List<dynamic>?)
          ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
      country: (json['country'] as List<dynamic>?)
          ?.map((e) => Country.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MovieDetailRespToJson(MovieDetailResp instance) =>
    <String, dynamic>{
      'created': instance.created,
      'modified': instance.modified,
      '_id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'origin_name': instance.originName,
      'content': instance.content,
      'type': instance.type,
      'status': instance.status,
      'poster_url': instance.posterUrl,
      'thumb_url': instance.thumbUrl,
      'is_copyright': instance.isCopyright,
      'sub_docquyen': instance.subDocQuyen,
      'chieurap': instance.chieuRap,
      'trailer_url': instance.trailerUrl,
      'time': instance.time,
      'episode_current': instance.episodeCurrent,
      'episode_total': instance.episodeTotal,
      'quality': instance.quality,
      'lang': instance.lang,
      'notify': instance.notify,
      'showtimes': instance.showTimes,
      'year': instance.year,
      'view': instance.view,
      'actor': instance.actor,
      'director': instance.director,
      'category': instance.category,
      'country': instance.country,
    };
