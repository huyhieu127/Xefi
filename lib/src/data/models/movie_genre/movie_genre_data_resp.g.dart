// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_genre_data_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieGenreDataResp _$MovieGenreDataRespFromJson(Map<String, dynamic> json) =>
    MovieGenreDataResp(
      movies: (json['items'] as List<dynamic>?)
          ?.map((e) => MovieGenreResp.fromJson(e as Map<String, dynamic>))
          .toList(),
      params: json['params'] == null
          ? null
          : Params.fromJson(json['params'] as Map<String, dynamic>),
      typeList: json['type_list'] as String?,
      appDomainFrontend: json['APP_DOMAIN_FRONTEND'] as String?,
      appDomainCdnImage: json['APP_DOMAIN_CDN_IMAGE'] as String?,
    );

Map<String, dynamic> _$MovieGenreDataRespToJson(MovieGenreDataResp instance) =>
    <String, dynamic>{
      'items': instance.movies,
      'params': instance.params,
      'type_list': instance.typeList,
      'APP_DOMAIN_FRONTEND': instance.appDomainFrontend,
      'APP_DOMAIN_CDN_IMAGE': instance.appDomainCdnImage,
    };
