part of 'play_movie_cubit.dart';

sealed class PlayMovieState extends Equatable {
  const PlayMovieState();
}

final class PlayMovieInitial extends PlayMovieState {
  @override
  List<Object> get props => [];
}

final class PlayMovieChangeEpisode extends PlayMovieState {
  final EpisodeEntity episode;
  final String thumbnailUrl;

  const PlayMovieChangeEpisode(
      {required this.episode, required this.thumbnailUrl});

  @override
  List<Object> get props => [episode, thumbnailUrl];
}
