import 'package:equatable/equatable.dart';

import '../export_entities.dart';

class ServerEntity extends Equatable {
  const ServerEntity({
    this.serverName,
    this.episodes,
  });

  final String? serverName; //server_name
  final List<EpisodeEntity>? episodes; //server_data

  @override
  List<Object?> get props => [serverName, episodes];


}
