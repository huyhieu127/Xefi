// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_newest_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieNewestResp _$MovieNewestRespFromJson(Map<String, dynamic> json) =>
    MovieNewestResp(
      json['modified'] == null
          ? null
          : Modified.fromJson(json['modified'] as Map<String, dynamic>),
      json['id'] as String?,
      json['name'] as String?,
      json['slug'] as String?,
      json['origin_name'] as String?,
      json['poster_url'] as String?,
      json['thumb_url'] as String?,
      (json['year'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MovieNewestRespToJson(MovieNewestResp instance) =>
    <String, dynamic>{
      'modified': instance.modified,
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'origin_name': instance.originName,
      'poster_url': instance.posterUrl,
      'thumb_url': instance.thumbUrl,
      'year': instance.year,
    };
