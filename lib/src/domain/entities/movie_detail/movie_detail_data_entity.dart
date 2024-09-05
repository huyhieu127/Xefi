import 'package:equatable/equatable.dart';
import 'package:xefi/src/domain/entities/export_entities.dart';

class MovieDetailDataEntity extends Equatable {
  final bool? status;
  final String? msg;
  final MovieDetailEntity? movie;
  final List<ServerEntity>? servers;

  const MovieDetailDataEntity({
    this.status,
    this.msg,
    this.movie,
    this.servers,
  });

  @override
  List<Object?> get props => [
        status,
        msg,
        movie,
        servers,
      ];

  List<EpisodeEntity> get episodesFirstServer => servers?.first.episodes ?? [];

  EpisodeEntity get latestEpisode => episodesFirstServer.last;
}
