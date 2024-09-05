import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:xefi/src/data/mapper/entity_convertor.dart';
import 'package:xefi/src/domain/entities/export_entities.dart';

import '../export_models.dart';

part 'server_resp.g.dart';

@JsonSerializable()
class ServerResp extends Equatable
    with EntityConvertor<ServerResp, ServerEntity> {
  const ServerResp({
    this.serverName,
    this.episodes,
  });

  @JsonKey(name: 'server_name')
  final String? serverName;
  @JsonKey(name: 'server_data')
  final List<EpisodeResp>? episodes;

  @override
  List<Object?> get props => [serverName, episodes];

  factory ServerResp.fromJson(Map<String, dynamic> json) =>
      _$ServerRespFromJson(json);

  Map<String, dynamic> toJson() => _$ServerRespToJson(this);

  @override
  ServerEntity toEntity() => ServerEntity(
        serverName: serverName,
        episodes: episodes?.map((resp) => resp.toEntity()).toList(),
      );
}
