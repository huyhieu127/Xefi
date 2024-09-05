import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:xefi/src/data/mapper/entity_convertor.dart';
import 'package:xefi/src/domain/entities/export_entities.dart';

part 'episode_resp.g.dart';

@JsonSerializable()
class EpisodeResp extends Equatable
    with EntityConvertor<EpisodeResp, EpisodeEntity> {
  const EpisodeResp({
    this.name,
    this.slug,
    this.filename,
    this.linkEmbed,
    this.linkM3u8,
  });

  final String? name;
  final String? slug;
  final String? filename;
  @JsonKey(name: 'link_embed')
  final String? linkEmbed;
  @JsonKey(name: 'link_m3u8')
  final String? linkM3u8;

  @override
  List<Object?> get props => [
        name,
        slug,
        filename,
        linkEmbed,
        linkM3u8,
      ];

  factory EpisodeResp.fromJson(Map<String, dynamic> json) =>
      _$EpisodeRespFromJson(json);

  Map<String, dynamic> toJson() => _$EpisodeRespToJson(this);

  @override
  EpisodeEntity toEntity() => EpisodeEntity(
        name: name,
        slug: slug,
        filename: filename,
        linkEmbed: linkEmbed,
        linkM3u8: linkM3u8,
      );
}
