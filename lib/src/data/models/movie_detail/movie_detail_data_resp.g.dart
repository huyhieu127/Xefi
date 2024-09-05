// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_detail_data_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieDetailDataResp _$MovieDetailDataRespFromJson(Map<String, dynamic> json) =>
    MovieDetailDataResp(
      status: json['status'] as bool?,
      msg: json['msg'] as String?,
      movie: json['movie'] == null
          ? null
          : MovieDetailResp.fromJson(json['movie'] as Map<String, dynamic>),
      episodes: (json['episodes'] as List<dynamic>?)
          ?.map((e) => ServerResp.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MovieDetailDataRespToJson(
        MovieDetailDataResp instance) =>
    <String, dynamic>{
      'status': instance.status,
      'msg': instance.msg,
      'movie': instance.movie,
      'episodes': instance.episodes,
    };
