// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResp _$BaseRespFromJson(Map<String, dynamic> json) => BaseResp(
      status: json['status'] as String?,
      message: json['message'] as String?,
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => MovieNewestResp.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..msg = json['msg'] as String?
      ..data = json['data'] == null
          ? null
          : MovieGenreDataResp.fromJson(json['data'] as Map<String, dynamic>);

Map<String, dynamic> _$BaseRespToJson(BaseResp instance) => <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'pagination': instance.pagination,
      'items': instance.items,
      'msg': instance.msg,
      'data': instance.data,
    };
