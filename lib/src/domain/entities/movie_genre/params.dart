import 'package:json_annotation/json_annotation.dart';

import '../export_entities.dart';

part 'params.g.dart';

@JsonSerializable()
class Params {
  Params({
    this.pagination,
  });
  Pagination? pagination;

  factory Params.fromJson(Map<String, dynamic> json) => _$ParamsFromJson(json);

  Map<String, dynamic> toJson() => _$ParamsToJson(this);
}
