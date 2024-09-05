import 'package:json_annotation/json_annotation.dart';
import 'package:xefi/src/domain/entities/export_entities.dart';

import '../export_models.dart';

part 'base_resp.g.dart';

@JsonSerializable()
class BaseResp {
  String? status;
  String? message;
  Pagination? pagination;
  List<MovieNewestResp>? items;
  String? msg;
  MovieGenreDataResp? data;

  BaseResp({this.status, this.message, this.pagination, this.items});

  factory BaseResp.fromJson(Map<String, dynamic> json) {
    var status = json['status'];
    if (status is bool) {
      json['status'] = status ? "success" : "failed";
    }
    return _$BaseRespFromJson(json);
  }

  Map<String, dynamic> toJson() => _$BaseRespToJson(this);
}
