import 'package:equatable/equatable.dart';

class EpisodeEntity extends Equatable {
  const EpisodeEntity({
    this.name,
    this.slug,
    this.filename,
    this.linkEmbed,
    this.linkM3u8,
  });

  final String? name;
  final String? slug;
  final String? filename;
  final String? linkEmbed; //link_embed
  final String? linkM3u8; //link_m3u8

  @override
  List<Object?> get props => [
        name,
        slug,
        filename,
        linkEmbed,
        linkM3u8,
      ];
}
