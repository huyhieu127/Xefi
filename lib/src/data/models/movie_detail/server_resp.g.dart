// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServerResp _$ServerRespFromJson(Map<String, dynamic> json) => ServerResp(
      serverName: json['server_name'] as String?,
      episodes: (json['server_data'] as List<dynamic>?)
          ?.map((e) => EpisodeResp.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ServerRespToJson(ServerResp instance) =>
    <String, dynamic>{
      'server_name': instance.serverName,
      'server_data': instance.episodes,
    };
