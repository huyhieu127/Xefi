part of 'video_player_cubit.dart';

sealed class VideoPlayerState extends Equatable {
  const VideoPlayerState();

  @override
  List<Object> get props => [];
}

final class VideoPlayerInitial extends VideoPlayerState {}

final class VideoPlayerChangeEpisode extends VideoPlayerState {
  final EpisodeEntity episode;

  const VideoPlayerChangeEpisode({required this.episode});

  @override
  List<Object> get props => [episode];
}

