// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_genre_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieGenreResp _$MovieGenreRespFromJson(Map<String, dynamic> json) =>
    MovieGenreResp(
      modified: json['modified'] == null
          ? null
          : Modified.fromJson(json['modified'] as Map<String, dynamic>),
      id: json['_id'] as String?,
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      originName: json['origin_name'] as String?,
      type: json['type'] as String?,
      posterUrl: json['poster_url'] as String?,
      thumbUrl: json['thumb_url'] as String?,
      subDocQuyen: json['sub_docquyen'] as bool?,
      chieuRap: json['chieurap'] as bool?,
      time: json['time'] as String?,
      episodeCurrent: json['episode_current'] as String?,
      quality: json['quality'] as String?,
      lang: json['lang'] as String?,
      year: (json['year'] as num?)?.toInt(),
      category: (json['category'] as List<dynamic>?)
          ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
      country: (json['country'] as List<dynamic>?)
          ?.map((e) => Country.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MovieGenreRespToJson(MovieGenreResp instance) =>
    <String, dynamic>{
      'modified': instance.modified,
      '_id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'origin_name': instance.originName,
      'type': instance.type,
      'poster_url': instance.posterUrl,
      'thumb_url': instance.thumbUrl,
      'sub_docquyen': instance.subDocQuyen,
      'chieurap': instance.chieuRap,
      'time': instance.time,
      'episode_current': instance.episodeCurrent,
      'quality': instance.quality,
      'lang': instance.lang,
      'year': instance.year,
      'category': instance.category,
      'country': instance.country,
    };
